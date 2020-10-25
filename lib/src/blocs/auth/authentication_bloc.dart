import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:newsapp/src/models/userRepo.dart';
import 'package:newsapp/src/repository/local_data.dart';
import 'package:newsapp/src/repository/user_repository.dart';
import './bloc.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final http.Client httpClient;
  LocalData prefs = LocalData();

  AuthenticationBloc({@required this.httpClient})
      : super(InitialAuthenticationState());

  @override
  Stream<Transition<AuthenticationEvent, AuthenticationState>> transformEvents(
    Stream<AuthenticationEvent> events,
    TransitionFunction<AuthenticationEvent, AuthenticationState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is Uninitialized) {
      yield AuthLoading();
      UserRespoModel userData;
      Future<String> userLocal = prefs.getuserData();
      userLocal.then((data) {
        print("***************this the data i have******************" + data.toString());
        userData = UserRespoModel.fromJson(jsonDecode(data.toString()));
      }, onError: (e) {
        print(e);
      });

      if (userData.apiStatus == "200") {
        print(
            "==========> we got data now nononnononononono${userData.apiStatus}<===========");
        yield Authenticated(userData: userData);
      } else {
        print("==========> no data found <===========");
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      prefs.setuserData("");
      yield AuthLoading();

      UserRespoModel userData = await UserRepository.loginOnBackend(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      if (userData.apiStatus == "200") {
        prefs.setuserData(jsonEncode(userData));
        print("=========  am here in bloc: " + jsonEncode(userData));
        Future<String> userLocal = prefs.getuserData();
        userLocal.then((data) {
          print("get from pref:" + data.toString());
        }, onError: (e) {
          print(e);
        });
        yield Authenticated(userData: userData);
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      prefs.setuserData("");
      yield Unauthenticated();
    }

    if (event is Autheticated) {
      UserRespoModel userData = event.userData;
      if (userData.apiStatus == "200") {
        print("==========> we got data now <===========");
        yield Authenticated(userData: userData);
      } else {
        print("==========> no data found <===========");
        yield Unauthenticated();
      }
    }
  }
}
