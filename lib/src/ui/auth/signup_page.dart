import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: ListView.builder(
        itemExtent: 250.0,
        itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(10.0),
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(5.0),
                color: index % 2 == 0 ? Color(0xFF018100) : Colors.grey[300],
                child: Center(
                  child: Text(index.toString()),
                ),
              ),
            ),
      ),
    );
  }
}