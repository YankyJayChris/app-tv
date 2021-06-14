// import 'package:equatable/equatable.dart';
// import '../../../src/models/check_payment.dart';


// abstract class PaymentState extends Equatable {
//   const PaymentState();

//   @override
//   List<Object> get props => [];
// }

// class PaymentInitial extends PaymentState {}

// class PaymentFailure extends PaymentState {
//   final String message;

//   PaymentFailure({this.message});

//   @override
//   List<Object> get props => [message];

//   @override
//   String toString() =>
//       'PostLoaded { mesage: $message}';
// }

// class PaymentSuccess extends PaymentState {
//   final CheckPaymentRepo payData;

//   const PaymentSuccess({
//     this.payData,
//   });

//   PaymentSuccess copyWith({
//     CheckPaymentRepo payData,
//   }) {
//     return PaymentSuccess(
//       payData: payData ?? this.payData,
//     );
//   }

//   @override
//   List<Object> get props => [payData];

//   @override
//   String toString() =>
//       'PostLoaded { Payment data: ${payData.toString()}}';
// }



// class PaymentLoading extends PaymentState {}

