import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import '../../../src/models/check_payment.dart';
import '../../../src/repository/new_local.dart';
import '../../../src/repository/payment_repository.dart';
import 'bloc.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentState> {
  final http.Client httpClient;
  // LocalData prefs = LocalData();
  LocalStorageService _localStorageService = LocalStorageService(
      localStorageRepository: LocalStorageRepository("prime.json"));

  PaymentsBloc({@required this.httpClient}) : super(PaymentInitial());

  @override
  Stream<Transition<PaymentsEvent, PaymentState>> transformEvents(
    Stream<PaymentsEvent> events,
    TransitionFunction<PaymentsEvent, PaymentState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<PaymentState> mapEventToState(
    PaymentsEvent event,
  ) async* {
    if (event is PaymentUninitialized) {
      yield PaymentLoading();
      CheckPaymentRepo paymentData;
      // Future<String> paymentLocal = prefs.getPayData();
      // paymentLocal.then((data) {
      //   print("***************this the data i have paypaypaypay******************" +
      //       data.toString());
      //   paymentData = CheckPaymentRepo.fromJson(jsonDecode(data.toString()));
      // }, onError: (e) {
      //   print(e);
      // });
      Future<String> paymentLocal = _localStorageService.getpayData();
      paymentData =
          CheckPaymentRepo.fromJson(jsonDecode(paymentLocal.toString()));

      if (paymentData.apiStatus == "200") {
        print(
            "==========> we got data now paypaypaypay${paymentData.apiStatus}<===========");
        yield PaymentSuccess(payData: paymentData);
      } else {
        print("==========> no data found paypaypaypay<===========");
        yield PaymentFailure(
            message: "Payment request failed, please try again");
      }
    }

    if (event is PaymentDone) {
      // prefs.setPayData("");
      await _localStorageService.removeFromStorage("paydata");
      yield PaymentLoading();

      CheckPaymentRepo paymentData = event.paymentData;

      if (paymentData.apiStatus == "200") {
        // prefs.setPayData(jsonEncode(paymentData));
        await _localStorageService
            .savepayData(jsonEncode(paymentData.toString()));
        print("=========  am here in Paymentbloc: " + jsonEncode(paymentData));
        // Future<String> paymentLocal = prefs.getuserData();
        // paymentLocal.then((data) {
        //   print("get from pref:" + data.toString());
        // }, onError: (e) {
        //   print(e);
        // });
        Future<String> paymentLocal = _localStorageService.getpayData();
        paymentData =
            CheckPaymentRepo.fromJson(jsonDecode(paymentLocal.toString()));
        yield PaymentSuccess(payData: paymentData);
      } else {
        yield PaymentFailure(
            message: "Payment request failed, please try again");
      }
    }

    if (event is PaymentFished) {
      yield PaymentLoading();
      // prefs.setPayData("");
      await _localStorageService.removeFromStorage("paydata");
      yield PaymentFailure(message: "Your current subscription has finished");
    }

    if (event is CheckPayStatus) {
      CheckPaymentRepo payData = await PaymentsRepository.checkPayment(
          userId: event.userId, s: event.s);
      print(
          "==========> CheckPayStatus Paymentbloc ${payData.toString()}<===========");
      if (payData.apiStatus == "200") {
        await _localStorageService.savepayData(jsonEncode(payData.toString()));
        print(
            "==========> we got data now Paymentbloc ${payData.toString()}<===========");
        yield PaymentSuccess(payData: payData);
      } else {
        print("==========> no data found <===========");
        yield PaymentFailure(
            message: "Payment request failed, please try again");
      }
    }
  }
}
