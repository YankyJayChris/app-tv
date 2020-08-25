import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:newsapp/src/models/userRepo.dart';

@immutable
abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserRespoModel userData;

  Authenticated({
    this.userData,
  });

  Authenticated copyWith({
    UserRespoModel userData,
  }) {
    return Authenticated(
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object> get props => [userData];

  @override
  String toString() =>
      'user loged in { user_data: ${jsonEncode(userData)},';
}

class Unauthenticated extends AuthenticationState {}

class Loading extends AuthenticationState {}