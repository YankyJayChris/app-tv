import 'package:flutter/material.dart';
import '../../../src/ui/widgets/contactus.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
            // Text(
            //   'TV1 PRIME',
            //   style: TextStyle(color: Colors.black, fontFamily: 'BebasNeue'),
            // ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/tv');
                },
                child: Icon(
                  Icons.live_tv,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/radio');
                },
                child: Icon(
                  Icons.radio,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/searchpage');
                  },
                  child: Icon(Icons.search, color: Colors.black)),
              SizedBox(width: 15),
              // GestureDetector(
              //   onTap: () {},
              //   child: Image.asset(
              //     'assets/icons/user.png',
              //     width: 40,
              //     height: 30,
              //   ),
              // )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ContactUs(
        cardColor: Colors.white,
        textColor: Colors.black,
        logo: AssetImage('assets/images/prime_logo.png'),
        email: 'tv1rwandapp@gmail.com',
        companyName: 'TV1 RWANDA',
        companyColor: Colors.purple,
        phoneNumber: '+25078942886',
        website: 'https://tv1prime.com/#About',
        tagLine: 'TV1 PRIME',
        taglineColor: Colors.purple,
        twitterHandle: 'tv1rwanda',
        facebookHandle: 'tv1rwanda',
        instagram: 'tv1rwanda',
      ),
    );
  }
}
