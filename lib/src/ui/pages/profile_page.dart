import 'package:custom_switch/custom_switch.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/auth/bloc.dart';
import '../../../src/blocs/payment/bloc.dart';
import '../../../src/models/user.dart';
import '../../../src/models/userRepo.dart';
import '../../../src/repository/local_data.dart';
import '../../../src/resources/strings.dart';
import '../../../src/ui/screens/login_btn.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  LocalData prefs = LocalData();
  UserRespoModel userData;
  bool subNot = true;

  @override
  void initState() {
    super.initState();
    _notification();
  }

  _notification() {
    Future<bool> notData = prefs.getsubNot();
    notData.then((data) {
      setState(() {
        subNot = data;
      });
      prefs.setsubNot(subNot);
    }, onError: (e) {
      print(e);
    });
    // print(userData.userData.avatar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          actions: <Widget>[
            Row(
              children: <Widget>[
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pushNamed(context, '/editProfile');
                //   },
                //   child: Icon(
                //     Icons.edit,
                //     color: Colors.black,
                //   ),
                // ),
                // SizedBox(width: 15),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pushNamed(context, '/searchpage');
                //   },
                //   child: Icon(Icons.search, color: Colors.black),
                // ),
                // SizedBox(width: 15),
                // GestureDetector(
                //   onTap: () {},
                //   child: Image.asset(
                //     'assets/icons/user.png',
                //     width: 40,
                //     height: 30,
                //   ),
                // )
                // Stack(
                //   children: <Widget>[
                //     new IconButton(
                //         icon: Icon(Icons.notifications, color: Colors.black),
                //         onPressed: () {}),
                //     2 != 0
                //         ? new Positioned(
                //             right: 11,
                //             top: 11,
                //             child: new Container(
                //               padding: EdgeInsets.all(2),
                //               decoration: new BoxDecoration(
                //                 color: Colors.red,
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               constraints: BoxConstraints(
                //                 minWidth: 14,
                //                 minHeight: 14,
                //               ),
                //               child: Text(
                //                 '2',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 8,
                //                 ),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ),
                //           )
                //         : new Container()
                //   ],
                // ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            )
          ],
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Authenticated) {
            print(state.userData.userData.avatar);
            return profileWithData(context, state.userData.userData, subNot);
          }
          if (state is Unauthenticated) {
            return CanLogin();
          }
          if (state is Uninitialized) {
            return CanLogin();
          }
          if (state is AuthLoading) {
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

  SingleChildScrollView profileWithData(
      BuildContext context, UserModel data, bool subNot) {
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
                              "${AppStrings.mainURL}${mydata.avatar}"),
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
                  child: BlocBuilder<PaymentsBloc, PaymentState>(
                    builder: (context, state) {
                      print(state.toString());
                      if (state is PaymentFailure) {
                        return FlatButton(
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
                            Navigator.pushNamed(context, '/cart',
                                arguments: mydata);
                          },
                          child: Text(
                            "Get premium - 300 RWF/mon",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        );
                      } else if (state is PaymentSuccess) {
                        return Text(
                          state.payData.message,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      }

                      return FlatButton(
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
                          Navigator.pushNamed(context, '/cart',
                              arguments: mydata);
                        },
                        child: Text(
                          "Get premium - 300 RWF/mon",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      );
                      // return Center(
                      //   child: CircularProgressIndicator(),
                      // );
                    },
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
                buildSwicher('Notifications', subNot),
                SizedBox(height: 8.0),
                buildAboutsDetail(context, 'about', "tv1 Prime"),
                SizedBox(height: 8.0),
                // buildprofileDetail('Favolite writers', "4"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                ),
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
              value: subNot,
              onChanged: (value) {
                print("VALUE : $value");
                setState(() {
                  subNot = value;
                });
                prefs.setsubNot(subNot);
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

  Widget buildAboutsDetail(BuildContext context, String prop, String data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/aboutus');
      },
      child: Container(
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
