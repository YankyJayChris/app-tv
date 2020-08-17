import 'package:flutter/material.dart';

import 'package:newsapp/src/ui/widgets/video_card_col.dart';

class LatestVideoWidget extends StatelessWidget {
  final data;

  LatestVideoWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (30 / 100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (ctx, i) => VideoWidgetHor(video: data[i]),
      ),
    );
  }
}
