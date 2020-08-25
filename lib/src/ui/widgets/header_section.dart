import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;

  final String route;

  HeaderSection({this.title, this.route});

  Widget more() {
    if (this.route == " ") {
      return SizedBox();
    } else {
      return InkWell(
        onTap: () {
          print("${this.route}");
        },
        child: Text(
          'View All',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              this.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // more()
          ],
        ),
      ),
    );
  }
}
