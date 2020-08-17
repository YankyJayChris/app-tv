import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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