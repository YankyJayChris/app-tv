
import 'package:equatable/equatable.dart';
  import 'package:meta/meta.dart';
import 'package:newsapp/src/models/userRepo.dart';

  @immutable
  abstract class AuthenticationEvent extends Equatable {
    AuthenticationEvent([List props = const []]);
  }

  class AppStarted extends AuthenticationEvent {
    @override
    String toString() => 'AppStarted';

    @override
    List<Object> get props => [];
  }

  class LoggedIn extends AuthenticationEvent {
    final String phoneNumber;
    final String password;

    LoggedIn({@required this.phoneNumber,@required this.password }) : super([phoneNumber,password]);

    @override
    String toString() => 'LoggedIn { data: $phoneNumber and $password }';

    @override
    List<Object> get props => [phoneNumber,password];
  }
  class Autheticated extends AuthenticationEvent {
    final UserRespoModel userData;

    Autheticated({@required this.userData }) : super([userData]);

    @override
    String toString() => 'Autheticated { data: $userData }';

    @override
    List<Object> get props => [userData];
  }

  class LoggedOut extends AuthenticationEvent {
    @override
    String toString() => 'LoggedOut';

    @override
    // TODO: implement props
    List<Object> get props => [];
  }
