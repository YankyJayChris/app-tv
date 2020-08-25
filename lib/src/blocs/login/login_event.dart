import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends LoginEvent {
  final String phoNo;

  SendOtpEvent({this.phoNo});
}

class AppStartEvent extends LoginEvent {}

class VerifyOtpEvent extends LoginEvent {
  final String otp;

  VerifyOtpEvent({this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class LoginCompleteEvent extends LoginEvent {
  final FirebaseUser firebaseUser;
  LoginCompleteEvent(this.firebaseUser);
}

class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent(this.message);
}