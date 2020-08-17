import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  IconData icon;
  bool bottomBar;

  //constructor
  CustomAppBar(
      {this.title = 'TV1 NEWS',
      this.icon = Icons.menu,
      this.bottomBar = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Text(
        '${this.title}',
        // style: TextStyle(
        //   color: Color(0xFF018100),
        // ),
      ),
      leading: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 46.0,
            child: Card(
              elevation: 5.0,
              shape: CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                height: 46.0,
                width: 46.0,
                child: Image.asset(
                  'assets/images/logotv1.png',
                ),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 46.0,
          child: Card(
            elevation: 5.0,
            shape: CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/searchPage');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                height: 46.0,
                width: 46.0,
                decoration: BoxDecoration(
                  color: Color(0xFF602e98),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);
}
