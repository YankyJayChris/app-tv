import 'package:flutter/material.dart';



import 'package:newsapp/src/ui/widgets/category.dart';

class CategoriesWidget extends StatelessWidget {
  final data;

  CategoriesWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 100.0,
        child: Row(
          // scrollDirection: Axis.horizontal,
          // // padding: const EdgeInsets.all(8),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CategoryWidget(title: 'TV', icon: Icons.live_tv, route: "tv",),
            CategoryWidget(title: 'Radio', icon: Icons.radio, route: "radio",),
            CategoryWidget(title: 'Report News', icon: Icons.present_to_all, route: "sendvideo",),
            CategoryWidget(title: 'Trending', icon: Icons.insert_chart, route: "trending",),
          ],
        ),
      ),
    );
  }
}
