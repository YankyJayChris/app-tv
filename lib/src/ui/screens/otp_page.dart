// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapp/src/blocs/login/bloc.dart';
// import 'package:numeric_keyboard/numeric_keyboard.dart';

// class OtpPage extends StatefulWidget {
//   const OtpPage({Key key}) : super(key: key);
//   @override
//   _OtpPageState createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   String text = '';

//   void _onKeyboardTap(String value) {
//     setState(() {
//       text = text + value;
//     });
//   }

//   Widget otpNumberWidget(int position) {
//     try {
//       return Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),
//         child: Center(
//             child: Text(
//           text[position],
//           style: TextStyle(color: Colors.black),
//         )),
//       );
//     } catch (e) {
//       return Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("OTP"),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                                 'Enter 6 digits verification code sent to your number',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 26,
//                                     fontWeight: FontWeight.w500))),
//                         Container(
//                           constraints: const BoxConstraints(maxWidth: 500),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               otpNumberWidget(0),
//                               otpNumberWidget(1),
//                               otpNumberWidget(2),
//                               otpNumberWidget(3),
//                               otpNumberWidget(4),
//                               otpNumberWidget(5),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ConfirmButton(text: text),
//                   NumericKeyboard(
//                     onKeyboardTap: _onKeyboardTap,
//                     textColor: Colors.purple[600],
//                     rightIcon: Icon(
//                       Icons.backspace,
//                       color: Colors.purple[600],
//                     ),
//                     rightButtonFn: () {
//                       setState(() {
//                         text = text.substring(0, text.length - 1);
//                       });
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ConfirmButton extends StatelessWidget {
//   const ConfirmButton({
//     Key key,
//     @required this.text,
//   }) : super(key: key);

//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(
//           horizontal: 20, vertical: 10),
//       constraints: const BoxConstraints(maxWidth: 500),
//       child: RaisedButton(
//         onPressed: () {
//           // loginStore.validateOtpAndLogin(context, text);
//           if(text != " " && text.length == 6){
//             BlocProvider.of<LoginBloc>(context)
//                 .add(VerifyOtpEvent(otp: text));
//             BlocProvider.of<LoginBloc>(context).add(AppStartEvent());
//           }else{

//           }
//         },
//         color: Colors.purple[800],
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(14))),
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//               vertical: 8, horizontal: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Confirm',
//                 style: TextStyle(color: Colors.white),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   borderRadius:
//                       const BorderRadius.all(Radius.circular(20)),
//                   color: Colors.purple[600],
//                 ),
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoadingIndicator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => Center(
//         child: CircularProgressIndicator(),
//       );
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/otp_input.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  OTPScreen({
    Key key,
    @required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Colors.black, hintText: '333333');

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    print("isValid - $isCodeSent");
    print("mobiel ${widget.mobileNumber}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 16, top: 4),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Verify Details",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "OTP sent to ${widget.mobileNumber}",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinInputTextField(
                pinLength: 6,
                decoration: _pinDecoration,
                controller: _pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  if (pin.length == 6) {
                    _onFormSubmitted();
                  } else {
                    showToast("Invalid OTP", Colors.red);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    child: Text(
                      "ENTER OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_pinEditingController.text.length == 6) {
                        _onFormSubmitted();
                      } else {
                        showToast("Invalid OTP", Colors.red);
                      }
                    },
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(message, Color color) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 2,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) {
        if (value.user != null) {
          // Handle loogged in state
          print(value.user.phoneNumber);
          
        } else {
          showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) {
      if (value.user != null) {
        // Handle loogged in state
        print(value.user.phoneNumber);
        Navigator.of(context).pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);
      } else {
        showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      showToast("Something went wrong", Colors.red);
    });
  }
}