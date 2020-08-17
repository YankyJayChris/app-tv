import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final String route;

  final IconData icon;

  CategoryWidget({this.title = 'TV', this.icon = Icons.live_tv,this.route= "home"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.5,
      child: Center(
        child: InkWell(
          onTap: () {
            print("${this.title} tapped");
            Navigator.pushNamed(context, '/${this.route}');
          },
          child: Column(
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple[100],
                ),
                child: Icon(
                  this.icon,
                  color: Colors.purple[800],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                this.title,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
