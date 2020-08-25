import 'package:flutter/material.dart';

class CanLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: profileWithData(context),
      ),
    );
  }

  Widget profileWithData(BuildContext context, {data= ''}) {
    return Column(
      children: <Widget>[
        Container(
          // height: MediaQuery.of(context).size.height * (100 / 100),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                child: Container(
                  child: Image.asset('assets/images/logo_44.png',),
                ),
              ),
              SizedBox(
                height: 100.0,
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
                     Navigator.pushNamed(context, '/signin');
                  },
                  child: Text(
                    "Login",
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
              buildprofileDetail(context,'about', "tv1 Prime"),
              SizedBox(height: 8.0),
              buildprofileDetail(context,'terms', "view"),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildprofileDetail(BuildContext context,String prop, String data) {
    return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/searchpage');
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
}