import 'package:flutter/material.dart';

class PrimeAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/logo_44.png',
            width: 40,
            height: 30,
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
              child: Icon(
                Icons.videocam,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
                onTap: () {}, child: Icon(Icons.search, color: Colors.black)),
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
    );
  }
}
