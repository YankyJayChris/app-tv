import 'package:flutter/material.dart';

import '../../../src/ui/widgets/category.dart';

class CategoriesWidget extends StatelessWidget {
  final data;

  CategoriesWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 110.0,
        child: Row(
          // scrollDirection: Axis.horizontal,
          // // padding: const EdgeInsets.all(8),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CategoryWidget(
              title: 'TV',
              icon: Icons.live_tv,
              route: "tv",
            ),
            CategoryWidget(
              title: 'Radio',
              icon: Icons.radio,
              route: "radio",
            ),
            CategoryWidget(
              title: 'Live events',
              icon: Icons.online_prediction,
              route: "live",
            ),
            CategoryWidget(
              title: 'Trending',
              icon: Icons.insert_chart,
              route: "trending",
            ),
          ],
        ),
      ),
    );
  }
}
