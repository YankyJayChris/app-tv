import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../src/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  StreamSubscription _subscription;

  StreamSubscription get subscription => _subscription;

  set subscription(StreamSubscription subscription) {
    _subscription = subscription;
  }

  String verID = "";

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(InitialLoginState());

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();

      subscription = sendOtp(event.phoNo).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.firebaseUser);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        AuthResult result =
            await _userRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield LoginCompleteState(result.user);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
    }
  }

  @override
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    print("Bloc closed");
    super.close();
  }

  Stream<LoginEvent> sendOtp(String phoNo) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _userRepository.getUser();
      _userRepository.getUser().catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };
    final phoneVerificationFailed = (AuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, [int forceResent]) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
    };
    final phoneCodeAutoRetrievalTimeout = (String verid) {
      this.verID = verid;
      eventStream.close();
    };

    await _userRepository.sendOtp(
        phoNo,
        Duration(seconds: 1),
        phoneVerificationFailed,
        phoneVerificationCompleted,
        phoneCodeSent,
        phoneCodeAutoRetrievalTimeout);

    yield* eventStream.stream;
  }
}
