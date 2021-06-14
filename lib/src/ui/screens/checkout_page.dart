import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../src/blocs/auth/bloc.dart';
import '../../../src/models/user.dart';
import '../../../src/repository/payment_repository.dart';
import '../../../src/ui/widgets/CustomShowDialog.dart';
import '../../../src/ui/widgets/inputPhone.dart';
import '../../../src/ui/widgets/rounded_bordered_container.dart';

class CheckoutOnePage extends StatefulWidget {
  final UserModel userDta;
  CheckoutOnePage({this.userDta});
  @override
  _CheckoutOnePageState createState() => _CheckoutOnePageState();
}

class _CheckoutOnePageState extends State<CheckoutOnePage> {
  String plan = "month";
  bool loading = false;
  String paymentMethode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    plan = "month";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Choose your plan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print("month");
                          setState(() {
                            plan = "month";
                          });
                        },
                        child: RoundedContainer(
                          color: (plan == "month")
                              ? Colors.purple[800]
                              : Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "300 RWF",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: (plan == "year")
                                      ? Colors.purple[800]
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Per month",
                                style: TextStyle(
                                  color: (plan == "year")
                                      ? Colors.purple[800]
                                      : Colors.white,
                                  fontSize: 12.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print("year");
                          setState(() {
                            plan = "year";
                          });
                        },
                        child: RoundedContainer(
                          color: (plan == "year")
                              ? Colors.purple[800]
                              : Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "2900 RWF",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: (plan == "month")
                                      ? Colors.purple[800]
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Per year",
                                style: TextStyle(
                                  color: (plan == "month")
                                      ? Colors.purple[800]
                                      : Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Payment methods",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("MTN");
                  setState(() {
                    paymentMethode = "MTN";
                  });
                  // showAlertDialog(context);
                  print("results: $plan");
                  Navigator.pushNamed(context, '/momonumber', arguments: plan);
                },
                child: RoundedContainer(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/MTN_MM.png',
                      width: 35,
                      height: 50,
                    ),
                    title: Text("MTN MOMO"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Airtel");
                  setState(() {
                    paymentMethode = "Airtel";
                  });
                },
                child: RoundedContainer(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/airtel_money.png',
                      width: 35,
                      height: 50,
                    ),
                    title: Text("Airtel Money"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Paypal");
                  setState(() {
                    paymentMethode = "Paypal";
                  });
                },
                child: RoundedContainer(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.paypal,
                      color: Colors.indigo,
                    ),
                    title: Text("Paypal"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 16.0,
              //     horizontal: 32.0,
              //   ),
              //   child: RaisedButton(
              //     elevation: 0,
              //     padding: const EdgeInsets.all(24.0),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0)),
              //     child: Text("Continue"),
              //     color: Colors.indigo,
              //     textColor: Colors.white,
              //     onPressed: () {},
              //   ),
              // )
            ],
          ),
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

  void showAlertDialog(
    BuildContext context,
  ) {
    String serverNumber;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              final sessionData = state.userData.data;
              final userData = state.userData.userData;
              String number = userData.phoneNumber;

              return CustomAlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 3.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: const Color(0xFFFFFF),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  child: Form(
                    key: _formKey,
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
                            serverNumber = value;
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
                        MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              var momoData = await PaymentsRepository.momopay(
                                s: "${sessionData.sessionId}",
                                userId: "${sessionData.userId}",
                                phoneNumber: serverNumber,
                                period: plan,
                              );
                              if (momoData.apiStatus == "200") {
                                setState(() {
                                  loading = false;
                                });
                                print("results: ${momoData.toString()}");
                                Navigator.pushNamed(context, '/momowaiting',
                                    arguments: {"refId": momoData.refId});
                              }
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 10,
                            padding: EdgeInsets.all(15.0),
                            child: Material(
                              color: Colors.purple[800],
                              borderRadius: BorderRadius.circular(25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Pay',
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
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
