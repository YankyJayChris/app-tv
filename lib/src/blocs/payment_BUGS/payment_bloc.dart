// // import 'dart:async';
// // import 'dart:convert';

// // import 'package:bloc/bloc.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:meta/meta.dart';
// // import '../../../src/blocs/Payment/bloc.dart';
// // import '../../../src/blocs/payment/payment_event.dart';
// // import '../../../src/models/check_payment.dart';
// // import '../../../src/models/momo_results.dart';
// // import '../../../src/models/userRepo.dart';
// // import '../../../src/repository/local_data.dart';
// // import '../../../src/repository/payment_repository.dart';
// // import 'package:rxdart/rxdart.dart';

// // class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
// //   final http.Client httpClient;
// //   LocalData prefs = LocalData();

// //   PaymentBloc({@required this.httpClient}) : super(PaymentInitial());

// //   @override
// //   Stream<Transition<PaymentEvent, PaymentState>> transformEvents(
// //     Stream<PaymentEvent> events,
// //     TransitionFunction<PaymentEvent, PaymentState> transitionFn,
// //   ) {
// //     return super.transformEvents(
// //       events.debounceTime(const Duration(milliseconds: 500)),
// //       transitionFn,
// //     );
// //   }

// //   @override
// //   Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
// //     if (event is AppStartEvent) {
// //       UserRespoModel userData;
// //       CheckPaymentRepo payData;
// //       String mystring;
// //       try {
// //         print("==========> PAYMENT USERDATA <===========");
// //         Future<String> userLocal = prefs.getuserData();
// //         userLocal.then((data) {
// //           print("==========> PAYMENT USERDATA INSED DATA<===========");
// //           userData = UserRespoModel.fromJson(jsonDecode(data.toString()));
// //           mystring = jsonDecode(data);
// //           // print(
// //           //     "==========> we got data now IN PAYMENT USERDATA ${userData.apiStatus}<===========");
// //         }, onError: (e) {
// //           print(e);
// //         });

// //         print("$mystring<===========");
// //         if (userData.apiStatus == "200") {
// //           print(
// //               "==========> we got data now IN PAYMENT USERDATA $mystring<===========");
// //           Future<String> payDataLocal = prefs.getPayData();
// //           payDataLocal.then((data) {
// //             print("this the data i have" + data.toString());
// //             payData = CheckPaymentRepo.fromJson(jsonDecode(data.toString()));
// //           }, onError: (e) {
// //             print(e);
// //           });
// //           if (payData.apiStatus == "200") {
// //             if (payData.days >= 0) {
// //               yield PaymentSuccess(payData: payData);
// //             } else {
// //               payData = await PaymentsRepository.checkPayment(
// //                 s: userData.data.sessionId,
// //                 userId: "${userData.data.userId}",
// //               );
// //               if (payData.days >= 0) {
// //                 prefs.setPayData(jsonEncode(payData));
// //                 yield PaymentSuccess(payData: payData);
// //               } else {
// //                 yield Nopayement(message: "please subscribe to premium");
// //               }
// //             }
// //           } else {
// //             yield Nopayement(message: "please subscribe to premium");
// //           }
// //         } else {
// //           print("==========> no data found <===========");
// //           yield Nopayement(message: "please subscribe to premium");
// //         }
// //       } catch (_) {
// //         yield ExceptionState(message: "Fail to request status $_");
// //       }
// //     }
// //     if (event is MomoRequestPay) {
// //       try {
// //         yield Loading();
// //         MomoResults momoData = await PaymentsRepository.momopay(
// //           s: event.s,
// //           userId: event.userId,
// //           phoneNumber: event.phoneNumber,
// //           period: event.period,
// //         );
// //         if (momoData.apiStatus == "200") {
// //           CheckPaymentRepo payData = await PaymentsRepository.checkPayment(
// //             s: event.s,
// //             userId: event.userId,
// //           );
// //           prefs.setuserData(jsonEncode(payData));
// //           yield PaymentSuccess(payData: payData);
// //         } else {
// //           yield PaymentFailure(message: "failed to pay");
// //         }
// //       } catch (_) {
// //         yield ExceptionState(message: "Fail to request payment");
// //       }
// //     } else if (event is MomoRequestPayStatus) {
// //       try {
// //         yield Loading();
// //         CheckPaymentRepo momoData = await PaymentsRepository.momoStatus(
// //           refId: event.refId,
// //           s: event.s,
// //           userId: event.userId,
// //         );
// //         if (momoData.apiStatus == "200") {
// //           CheckPaymentRepo payData = await PaymentsRepository.checkPayment(
// //             s: event.s,
// //             userId: event.userId,
// //           );
// //           prefs.setuserData(jsonEncode(payData));
// //           yield PaymentSuccess(payData: payData);
// //         } else {
// //           yield PaymentFailure(message: "failed to pay");
// //         }
// //       } catch (_) {
// //         yield ExceptionState(message: "Fail to request status");
// //       }
// //     } else if (event is PaymentDone) {

// //     }
// //   }
// // }

// import 'dart:async';
// import 'dart:convert';
// import 'package:bloc/bloc.dart';
// import '../../../src/models/check_payment.dart';
// import '../../../src/repository/local_data.dart';
// import '../../../src/repository/payment_repository.dart';
// import './bloc.dart';

// import 'package:http/http.dart' as http;
// import 'package:meta/meta.dart';
// import 'package:rxdart/rxdart.dart';

// class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
//   final http.Client httpClient;
//   LocalData prefs = LocalData();

//   PaymentBloc({@required this.httpClient}) : super(PaymentInitial());

//   @override
//   Stream<Transition<PaymentEvent, PaymentState>> transformEvents(
//     Stream<PaymentEvent> events,
//     TransitionFunction<PaymentEvent, PaymentState> transitionFn,
//   ) {
//     return super.transformEvents(
//       events.debounceTime(const Duration(milliseconds: 500)),
//       transitionFn,
//     );
//   }

//   @override
//   Stream<PaymentState> mapEventToState(
//     PaymentEvent event,
//   ) async* {
//     if (event is PaymentInitial) {
//       yield PaymentLoading();
//       CheckPaymentRepo mypayData;
//       Future<String> payLocal = prefs.getPayData();
//       payLocal.then((data) {
//         print("***************this the data i have******************" +
//             data.toString());
//         mypayData = CheckPaymentRepo.fromJson(jsonDecode(data.toString()));
//       }, onError: (e) {
//         print(e);
//       });

//       if (mypayData.apiStatus == "200") {
//         print(
//             "==========> we got data now nononnononononono${mypayData.apiStatus}<===========");
//         yield PaymentSuccess(payData: mypayData);
//       } else {
//         print("==========> no data found <===========");
//         yield PaymentFailure(
//             message: "Payment request failed, please try again");
//       }
//     }

//     if (event is PaymentDone) {
//       prefs.setPayData("");
//       yield PaymentLoading();
//       CheckPaymentRepo mypayData = event.paymentData;

//       if (mypayData.apiStatus == "200") {
//         prefs.setuserData(jsonEncode(mypayData));
//         print("=========  am here in bloc: " + jsonEncode(mypayData));
//         Future<String> mypayDatalocal = prefs.getPayData();
//         mypayDatalocal.then((data) {
//           print("get from pref:" + data.toString());
//         }, onError: (e) {
//           print(e);
//         });
//         yield PaymentSuccess(payData: mypayData);
//       } else {
//         yield PaymentFailure(
//             message: "Payment request failed, please try again");
//       }
//     }

//     if (event is CheckPayStatus) {
//       CheckPaymentRepo payData = await PaymentsRepository.checkPayment(
//         userId: event.userId,
//         s: event.s
//       );
//       if (payData.apiStatus == "200") {
//         print("==========> we got data now <===========");
//         yield PaymentSuccess(payData: payData);
//       } else {
//         print("==========> no data found <===========");
//         yield PaymentFailure(
//             message: "Payment request failed, please try again");
//       }
//     }
//   }
// }
