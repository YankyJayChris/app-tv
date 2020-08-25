import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:newsapp/src/models/userRepo.dart';
import 'package:newsapp/src/repository/user_preferences.dart';
import 'package:newsapp/src/repository/user_repository.dart';
import './bloc.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final http.Client httpClient;

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
      final Map myuserData = UserPreferences().userData;
      UserRespoModel userData = UserRespoModel.fromJson(myuserData);

      if (userData.apiStatus == "200") {
        print("app stated");
        yield Authenticated(userData: userData);
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      UserPreferences().userData = " ";
      print("=========  am here in bloc  ==========");
      yield Loading();

      UserRespoModel userData = await UserRepository.loginOnBackend(
        phoneNumber: event.phoneNumber,
        password: event.phoneNumber,
      );
      if (userData.apiStatus == "200") {
        UserPreferences().userData = jsonEncode(userData);
        print("=========  am here in bloc: " + UserPreferences().userData);
        yield Authenticated(userData: userData);
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedOut) {
      yield Loading();
      UserPreferences().userData = " ";
      yield Unauthenticated();
    }
  }
}
