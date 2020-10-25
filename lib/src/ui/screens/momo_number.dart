import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/auth/bloc.dart';
import 'package:newsapp/src/blocs/payment/bloc.dart';
import 'package:newsapp/src/models/check_payment.dart';
import 'package:newsapp/src/models/momo_results.dart';
import 'package:newsapp/src/models/session_data.dart';
import 'package:newsapp/src/repository/local_data.dart';
import 'package:newsapp/src/repository/payment_repository.dart';
import 'package:newsapp/src/ui/widgets/inputPhone.dart';

class MomoNumber extends StatefulWidget {
  final String plan;
  MomoNumber({this.plan});
  @override
  _MomoNumberState createState() => _MomoNumberState();
}

class _MomoNumberState extends State<MomoNumber> {
  final _formKey = GlobalKey<FormState>();
  String number;
  String plan;
  bool loading = false;
  LocalData prefs = LocalData();
  PaymentsBloc _paymentBlocBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      plan = widget.plan;
    });
    _paymentBlocBloc = BlocProvider.of<PaymentsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              final sessionData = state.userData.data;
              final userData = state.userData.userData;
              number = userData.phoneNumber;

              return Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Enter your MTN mobile money number:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                          MyPhoneFormField(
                            initialValue: (number.startsWith("+25078"))
                                ? number.substring(3)
                                : '078',
                            hintText: 'Example: 078****606',
                            validator: validateMobile,
                            onSaved: (String value) {
                              number = value;
                            },
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Your paying ${(plan == "year") ? "2900 Rwf/year" : "300 Rwf/month"}",
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        setState(() {
                                          loading = true;
                                        });
                                        MomoResults momoData =
                                            await PaymentsRepository.momopay(
                                          s: "${sessionData.sessionId}",
                                          userId: "${sessionData.userId}",
                                          phoneNumber: number,
                                          period: plan,
                                        );
                                        if (momoData.apiStatus == "200") {
                                          print(" in process waiting page");

                                          Map<String, String> mynewdata = {
                                            "s": "${sessionData.sessionId}",
                                            "userId": "${sessionData.userId}",
                                            "plan": "$plan",
                                            "refId": momoData.refId
                                          };
                                          Session mydata =
                                              Session.fromJson(mynewdata);
                                          Timer(Duration(seconds: 10),
                                              () async {
                                            CheckPaymentRepo response =
                                                await PaymentsRepository.momoStatus(
                                                    refId: momoData.refId,
                                                    s: sessionData.sessionId,
                                                    userId:
                                                        "${sessionData.userId}");
                                            print(
                                                "again : ${response.toString()}");
                                            if (response.apiStatus == "200") {
                                              setState(() {
                                                loading = false;
                                              });
                                              print("am above payment now");
                                              _paymentBlocBloc.add(PaymentDone(
                                                      paymentData: response));
                                              Navigator.pushNamed(
                                                  context, '/home',
                                                  arguments: 4);
                                            } else {
                                              Navigator.pushNamed(
                                                  context, '/momowaiting',
                                                  arguments: mydata);
                                            }
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      padding: EdgeInsets.all(15.0),
                                      child: Material(
                                        color: Colors.purple[800],
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Pay ${(plan == "year") ? "2900 Rwf/year" : "300 Rwf/month"}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        buildRowText("1.",
                            "Click on the Pay button in order to initiate the MTN Mobile Money payment."),
                        buildRowText("2.",
                            "Check your mobile phone for a prompt requesting authorization of payment."),
                        buildRowText("3.",
                            "Authorize the payment and it will be deducted from your MTN Mobile Money balance."),
                        buildRowText("4.",
                            "Click on the Pay button in order to initiate the MTN Mobile Money payment."),
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  Widget buildRowText(step, text) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              step,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
