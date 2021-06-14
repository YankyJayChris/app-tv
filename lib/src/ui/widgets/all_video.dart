import 'package:flutter/material.dart';

import '../../../src/ui/widgets/video_row_card.dart';

class AllVideoWidget extends StatelessWidget {
  final data;

  AllVideoWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (ctx, i) => VideoWidgetRow(),
      ),
    );
  }
}
