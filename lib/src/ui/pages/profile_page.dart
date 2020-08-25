import 'dart:convert';

import 'package:custom_switch/custom_switch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/auth/bloc.dart';
import 'package:newsapp/src/models/user.dart';
import 'package:newsapp/src/repository/user_preferences.dart';
import 'package:newsapp/src/resources/strings.dart';
import 'package:newsapp/src/ui/screens/login_btn.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userData = UserPreferences().userData;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    print("user from pref: "+userData);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Authenticated) {
            return profileWithData(context, state.userData.userData);
          }
          if (state is Unauthenticated) {
            return CanLogin();
          }
          if (state is Uninitialized) {
            return CanLogin();
          }
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: CanLogin(),
          );
        }),
      ),
    );
  }

  SingleChildScrollView profileWithData(BuildContext context, UserModel data) {
    final mydata = data;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * (40 / 100),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: Card(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.purple[800],
                        image: DecorationImage(
                          image: NetworkImage(
                              AppStrings.mainURL + "${mydata.avatar}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.white,
                          width: 8.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  mydata.username,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "${mydata.firstName} ${mydata.lastName}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 45,
                  child: FlatButton(
                    color: Colors.purple[800],
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      /*...*/
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                buildprofileDetail(
                  'Email',
                  mydata.email,
                ),
                SizedBox(height: 8.0),
                buildprofileDetail('Country',
                    (mydata.countryId == 0) ? "Rwanda" : mydata.countryId),
                SizedBox(height: 8.0),
                buildprofileDetail(
                    'City', (mydata.city == "") ? "Kigali" : mydata.city),
                SizedBox(height: 30.0),
                buildSwicher('Notifications', true),
                SizedBox(height: 8.0),
                // buildprofileDetail('Favolite writers', "4"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildprofileDetail(String prop, String data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$prop:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              data,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSwicher(String prop, bool data) {
    final FirebaseMessaging _messaging = FirebaseMessaging();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '$prop:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomSwitch(
              activeColor: Colors.purple[800],
              value: data,
              onChanged: (value) {
                print("VALUE : $value");
                if (value == true) {
                  _messaging.subscribeToTopic('news');
                } else {
                  _messaging.unsubscribeFromTopic('news');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
