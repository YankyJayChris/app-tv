
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/src/models/check_payment.dart';

  @immutable
  abstract class PaymentsEvent extends Equatable {
    PaymentsEvent([List props = const []]);
  }

  class PaymentsStarted extends PaymentsEvent {
    @override
    String toString() => 'AppStarted';

    @override
    List<Object> get props => [];
  }

  class PaymentDone extends PaymentsEvent {
    final CheckPaymentRepo paymentData;

    PaymentDone({@required this.paymentData}) : super([paymentData]);

    @override
    String toString() => 'paying { data: $paymentData}';

    @override
    List<Object> get props => [paymentData];
  }
  class CheckPayStatus extends PaymentsEvent {
   final String s;
    final String userId;

    CheckPayStatus({@required this.s,@required this.userId}) : super([s,userId]);

    @override
    String toString() => 'Check Payment Status { data: $s,$userId }';

    @override
    List<Object> get props => [s,userId];
  }

    class PaymentFished extends PaymentsEvent {
    @override
    String toString() => 'Payment Fished';

    @override
    // TODO: implement props
    List<Object> get props => [];
  }

