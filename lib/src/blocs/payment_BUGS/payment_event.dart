// // import 'package:equatable/equatable.dart';
// // import 'package:meta/meta.dart';
// // import '../../../src/models/check_payment.dart';

// //   @immutable
// //   abstract class PaymentEvent extends Equatable {
// //     PaymentEvent([List props = const []]);
// //   }



// // class MomoRequestPay extends PaymentEvent {
// //   final String s;
// //   final String userId;
// //   final String phoneNumber;
// //   final String period;

// //     MomoRequestPay({@required this.s,@required this.userId,@required this.phoneNumber,@required this.period}) : super([s,userId,phoneNumber,period]);

// //     @override
// //     String toString() => 'MomoRequestPay { data: $phoneNumber and $period}';

// //     @override
// //     List<Object> get props => [s,userId,phoneNumber,period];
// // }

// // class CheckPayStatus extends PaymentEvent {

// //   final String s;
// //   final String userId;

// //     CheckPayStatus({@required this.s,@required this.userId}) : super([s,userId]);

// //     @override
// //     String toString() => 'CheckPayStatus { data: $s ,$userId}';

// //     @override
// //     List<Object> get props => [s,userId];
// // }
// // class PaymentDone extends PaymentEvent {
// //   final CheckPaymentRepo paymentData;
  

// //     PaymentDone({@required this.paymentData,}) : super([paymentData,]);

// //     @override
// //     String toString() => 'PaymentDone { data: $paymentData}';

// //     @override
// //     List<Object> get props => [paymentData];
// // }

// // class PaymentExceptionEvent extends PaymentEvent {
// //   final String message;

// //   PaymentExceptionEvent(this.message);

// //   @override
// //   List<Object> get props => [message];
// // }

// // class AppStartEvent extends PaymentEvent {
// //   @override
// //   // TODO: implement props
// //   List<Object> get props => throw UnimplementedError();
// // }



// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import '../../../src/models/check_payment.dart';

//   @immutable
//   abstract class PaymentEvent extends Equatable {
//     PaymentEvent([List props = const []]);
//   }

//   class AppStartEvent extends PaymentEvent {
//     @override
//     String toString() => 'AppStarted';

//     @override
//     List<Object> get props => [];
//   }

//   class PaymentDone extends PaymentEvent {
//     final CheckPaymentRepo paymentData;

//     PaymentDone({@required this.paymentData,}) : super([paymentData,]);

//     @override
//     String toString() => 'LoggedIn { data: $paymentData}';

//     @override
//     List<Object> get props => [paymentData];
//   }
//   class CheckPayStatus extends PaymentEvent {
//     final String s;
//     final String userId;

//     CheckPayStatus({@required this.s,@required this.userId}) : super([s,userId]);

//     @override
//     String toString() => 'Autheticated { data: $s,$userId }';

//     @override
//     List<Object> get props => [s,userId];
//   }

