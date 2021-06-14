import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/check_payment.dart';
import '../../models/session_data.dart';
import '../../resources/strings.dart';

class MomoWaiting extends StatefulWidget {
  final Session data;
  MomoWaiting({this.data});

  @override
  _MomoWaitingState createState() => _MomoWaitingState();
}

class _MomoWaitingState extends State<MomoWaiting> {
  var data;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo_44.png',
                  width: 100,
                  height: 200,
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: getPaymentStatus(data.refId, data.s, data.userId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Text(
                      snapshot.data.message,
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<CheckPaymentRepo> getPaymentStatus(
      String refId, String s, String userId) async {
    print("Check payment https");
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
      var data = json.decode(response.body);
      print(data);
      CheckPaymentRepo paymentStatus = CheckPaymentRepo.fromJson(data);
      return paymentStatus;
    } else {
      throw Exception();
    }
  }
}
