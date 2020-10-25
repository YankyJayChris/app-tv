import 'package:flutter/material.dart';
import 'package:newsapp/src/models/edit_user.dart';
import 'package:newsapp/src/ui/widgets/inputText.dart';
import 'package:validators/validators.dart' as validator;

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  EditUserModel model = EditUserModel();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.black,
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
          // actions: <Widget>[
          //   Row(
          //     children: <Widget>[
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.pushNamed(context, '/sendvideo');
          //         },
          //         child: Icon(
          //           Icons.edit,
          //           color: Colors.black,
          //         ),
          //       ),
          //       SizedBox(width: 15),
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.pushNamed(context, '/searchpage');
          //         },
          //         child: Icon(Icons.search, color: Colors.black),
          //       ),
          //       SizedBox(width: 15),
          //       GestureDetector(
          //         onTap: () {},
          //         child: Image.asset(
          //           'assets/icons/user.png',
          //           width: 40,
          //           height: 30,
          //         ),
          //       ),
          //       Stack(
          //         children: <Widget>[
          //           new IconButton(
          //               icon: Icon(Icons.notifications, color: Colors.black),
          //               onPressed: () {}),
          //           2 != 0
          //               ? new Positioned(
          //                   right: 11,
          //                   top: 11,
          //                   child: new Container(
          //                     padding: EdgeInsets.all(2),
          //                     decoration: new BoxDecoration(
          //                       color: Colors.red,
          //                       borderRadius: BorderRadius.circular(6),
          //                     ),
          //                     constraints: BoxConstraints(
          //                       minWidth: 14,
          //                       minHeight: 14,
          //                     ),
          //                     child: Text(
          //                       '2',
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 8,
          //                       ),
          //                       textAlign: TextAlign.center,
          //                     ),
          //                   ),
          //                 )
          //               : new Container()
          //         ],
          //       ),
          //     ],
          //     mainAxisAlignment: MainAxisAlignment.end,
          //   )
          // ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                hintText: 'Userame',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter your Username';
                  }
                  return null;
                },
                onSaved: (String value) {
                  model.lastName = value;
                },
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: MyTextFormField(
                        hintText: 'First Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.firstName = value;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediaWidth,
                      child: MyTextFormField(
                        hintText: 'Last Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.lastName = value;
                        },
                      ),
                    )
                  ],
                ),
              ),
              MyTextFormField(
                hintText: 'Email',
                isEmail: true,
                validator: (String value) {
                  if (!validator.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (String value) {
                  model.email = value;
                },
              ),
              MyTextFormField(
                hintText: 'Password',
                isPassword: true,
                validator: (String value) {
                  if (value.length < 7) {
                    return 'Password should be minimum 7 characters';
                  }

                  _formKey.currentState.save();

                  return null;
                },
                onSaved: (String value) {
                  model.password = value;
                },
              ),
              MyTextFormField(
                hintText: 'Confirm Password',
                isPassword: true,
                validator: (String value) {
                  if (value.length < 7) {
                    return 'Password should be minimum 7 characters';
                  } else if (model.password != null &&
                      value != model.password) {
                    print(value);
                    print(model.password);
                    return 'Password not matched';
                  }

                  return null;
                },
              ),
              RaisedButton(
                color: Colors.purple[800],
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    // to do navigate back to profile
                  }
                },
                child: Text(
                  'Save profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


