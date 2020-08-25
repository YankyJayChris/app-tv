import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:newsapp/src/blocs/login/bloc.dart';
import 'package:newsapp/src/repository/user_repository.dart';

class MyLoginPage extends StatelessWidget {
  UserRepository userRepository;

  MyLoginPage({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepository: userRepository),
      child: LoginPage(userRepository: userRepository),
    );
  }
}

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({@required this.userRepository});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();

  String _selected = "+250";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selected = "+250";
    });
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ExceptionState || state is OtpExceptionState) {
            String message;
            if (state is ExceptionState) {
              message = state.message;
            } else if (state is OtpExceptionState) {
              message = state.message;
            }
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(message), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Container(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                  return Column(
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                          'assets/images/logo_44.png')),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'We will send you an ',
                                      style:
                                          TextStyle(color: Colors.purple[800])),
                                  TextSpan(
                                      text: 'One Time Password ',
                                      style: TextStyle(
                                          color: Colors.purple[800],
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'on this mobile number',
                                      style:
                                          TextStyle(color: Colors.purple[800])),
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
                                  constraints:
                                      const BoxConstraints(maxWidth: 150),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: CupertinoTextField(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4))),
                                    controller: phoneController,
                                    clearButtonMode:
                                        OverlayVisibilityMode.editing,
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
                                  loginBloc.add(
                                    SendOtpEvent(
                                        phoNo: "$_selected" +
                                            phoneController.text.toString()),
                                  );
                                  print(phoneController.text.toString());
                                  Navigator.pushNamed(context, '/otpPage');
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                  );
                }),
              ),
            ),
          ),
        ));
  }

}

// import 'package:flutter/material.dart';

// class PhoneLogin extends StatefulWidget {
//   PhoneLogin({Key key}) : super(key: key);

//   @override
//   _PhoneLoginState createState() => _PhoneLoginState();
// }

// class _PhoneLoginState extends State<PhoneLogin> {
//   final TextEditingController _phoneNumberController = TextEditingController();

//   bool isValid = false;

//   Future<Null> validate(StateSetter updateState) async {
//     print("in validate : ${_phoneNumberController.text.length}");
//     if (_phoneNumberController.text.length == 10) {
//       updateState(() {
//         isValid = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.4,
//       padding: EdgeInsets.only(left: 8.0, top: 30),
//       alignment: Alignment.center,
//       child: new RaisedButton(
//         shape: new RoundedRectangleBorder(
//           borderRadius: new BorderRadius.circular(30.0),
//         ),
//         color: Colors.green,
//         onPressed: () => {},
//         child: new Container(
//           child: new Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               new Expanded(
//                 child: new FlatButton(
//                   onPressed: () {
//                     print("pressed");
//                     showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         builder: (BuildContext bc) {
//                           print("VALID CC: $isValid");

//                           return StatefulBuilder(builder:
//                               (BuildContext context, StateSetter state) {
//                             return Container(
//                               padding: EdgeInsets.all(16),
//                               height: MediaQuery.of(context).size.height * 0.7,
//                               child: new Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     'LOGIN',
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w900,
//                                         color: Colors.black),
//                                   ),
//                                   Text(
//                                     'Login/Create Account',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.black),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(bottom: 0),
//                                     child: TextFormField(
//                                       keyboardType: TextInputType.number,
//                                       controller: _phoneNumberController,
//                                       autofocus: true,
//                                       onChanged: (text) {
//                                         validate(state);
//                                       },
//                                       decoration: InputDecoration(
//                                         labelText: "10 digit mobile number",
//                                         prefix: Container(
//                                           padding: EdgeInsets.all(4.0),
//                                           child: Text(
//                                             "+250",
//                                             style: TextStyle(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ),
//                                       ),
//                                       autovalidate: true,
//                                       autocorrect: false,
//                                       maxLengthEnforced: true,
//                                       validator: (value) {
//                                         return !isValid
//                                             ? 'Please provide a valid 10 digit phone number'
//                                             : null;
//                                       },
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.all(16),
//                                     child: Center(
//                                       child: SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.85,
//                                         child: RaisedButton(
//                                           color: !isValid
//                                               ? Theme.of(context)
//                                                   .primaryColor
//                                                   .withOpacity(0.5)
//                                               : Theme.of(context).primaryColor,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(0.0)),
//                                           child: Text(
//                                             !isValid
//                                                 ? "ENTER PHONE NUMBER"
//                                                 : "CONTINUE",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           onPressed: () {
//                                             if (isValid) {
//                                               Navigator.pushNamed(
//                                                 context,
//                                                 '/otpPage',
//                                                 arguments:
//                                                     _phoneNumberController.text,
//                                               );
                                              
//                                             } else {
//                                               validate(state);
//                                             }
//                                           },
//                                           padding: EdgeInsets.all(16.0),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           });
//                         });
//                   },
//                   padding: EdgeInsets.only(
//                     top: 20.0,
//                     bottom: 20.0,
//                   ),
//                   child: new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Text(
//                         "Phone",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
