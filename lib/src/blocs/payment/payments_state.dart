import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:newsapp/src/models/check_payment.dart';
import 'package:newsapp/src/models/userRepo.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentUninitialized extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final CheckPaymentRepo payData;

  PaymentSuccess({
    this.payData,
  });

  PaymentSuccess copyWith({
    UserRespoModel payData,
  }) {
    return PaymentSuccess(
      payData: payData ?? this.payData,
    );
  }

  @override
  List<Object> get props => [payData];

  @override
  String toString() =>
      'Payment success in { user_data: ${jsonEncode(payData)},';
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure({
    this.message,
  });

  PaymentFailure copyWith({
    UserRespoModel message,
  }) {
    return PaymentFailure(
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message];

  @override
  String toString() =>
      'payment failed in { message: $message},';
}

class Unpayed extends PaymentState {}

class PaymentLoading extends PaymentState {}