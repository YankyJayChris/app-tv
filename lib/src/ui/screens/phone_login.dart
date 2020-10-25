import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneLoginPage extends StatefulWidget {
  PhoneLoginPage({Key key}) : super(key: key);

  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  TextEditingController phoneController = TextEditingController();

  String _selected = "+250";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _selected = "+250";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                                constraints:
                                    const BoxConstraints(maxHeight: 340),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child:
                                    Image.asset('assets/images/logo_44.png')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'We will send you an ',
                                style: TextStyle(color: Colors.purple[800])),
                            TextSpan(
                                text: 'One Time Password ',
                                style: TextStyle(
                                    color: Colors.purple[800],
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'on this mobile number',
                                style: TextStyle(color: Colors.purple[800])),
                          ]),
                        )),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CountryCodePicker(
                                enabled: true,
                                onChanged: (c) {
                                  setState(() {
                                    print("${c.dialCode}");
                                    _selected = "${c.dialCode}";
                                  });
                                },
                                initialSelection: 'RW',
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: false,
                                favorite: ['+250', 'RW'],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            constraints: const BoxConstraints(maxWidth: 150),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: CupertinoTextField(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              controller: phoneController,
                              clearButtonMode: OverlayVisibilityMode.editing,
                              keyboardType: TextInputType.phone,
                              maxLines: 1,
                              placeholder: '78...',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: RaisedButton(
                        onPressed: () {
                          if (phoneController.text.isNotEmpty &&
                              phoneController.text.length == 9) {
                            // loginBloc.add(
                            //   SendOtpEvent(
                            //       phoNo: "$_selected" +
                            //           phoneController.text.toString()),
                            // );
                            // Navigator.pushNamed(context, '/otpPage');
                            print(phoneController.text.toString());
                            Navigator.pushNamed(
                              context,
                              '/otpPage',
                              arguments: "$_selected" + phoneController.text.toString(),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(
                              new SnackBar(
                                  content: new Text(
                                      'Please provide valide number!'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        color: Colors.purple[800],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.purple[600],
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],

        ),
        ),
    ));
  }
}