import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/check_payment.dart';
import 'package:newsapp/src/models/momo_results.dart';
import 'package:newsapp/src/repository/local_data.dart';
import 'package:newsapp/src/resources/strings.dart';

class PaymentsRepository {
  static Future<MomoResults> momopay(
      {String s, String userId, String phoneNumber, String period}) async {
    print("am here in momo http");
    var body = {
      "s": s,
      "user_id": userId,
      "phone_number": "25" + phoneNumber,
      "period": period,
    };
    // print("again : $body");
    final response = await http.post(
      AppStrings.primeURL + '?type=momopay',
      body: body,
    );

    if (response.statusCode == 200) {
      print("again : am here in momo response");
      // print(response.body);
      var data = json.decode(response.body);
      MomoResults momoresult = MomoResults.fromJson(data);
      print("*****DONE MOMO REQUEST**********");
      return momoresult;
    } else {
      print("again : am in exception plz");
      throw Exception();
    }
  }

  static Future<CheckPaymentRepo> momoStatus(
      {String refId, String s, String userId}) async {
    print("am here in momo http");
    var body = {
      "ref_id": refId,
      "s": s,
      "user_id": userId,
    };
    print("again : $body");
    final response = await http.post(
      AppStrings.primeURL + '?type=momopay',
      body: body,
    );

    if (response.statusCode == 200) {
      print("again : am here in momo response");
      print(response.body);
      var data = json.decode(response.body);
      CheckPaymentRepo momoresult = CheckPaymentRepo.fromJson(data);
      return momoresult;
    } else {
      print("again : am in exception plz");
      throw Exception();
    }
  }

  static Future<CheckPaymentRepo> checkPayment(
      {String userId, String s}) async {
    print("am here in check payment http");
    var body = {
      "user_id": userId,
      "s": s,
    };
    print("again : $body");
    final response = await http.post(
      AppStrings.primeURL + '?type=check_payment',
      body: body,
    );

    if (response.statusCode == 200) {
      print("again : am here in check payment response");
      print(response.body);
      var data = json.decode(response.body);
      LocalData prefs = LocalData();
      CheckPaymentRepo payment = CheckPaymentRepo.fromJson(data);
      if (payment.apiStatus == "200") {
        prefs.setPayData(jsonEncode(payment));
      } else {
        prefs.setPayData("");
      }
      return payment;
    } else {
      print("again : am in exception plz");
      throw Exception();
    }
  }
}
