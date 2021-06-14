import 'package:flutter/material.dart';
import '../../../src/ui/widgets/recommended_news.dart';

class HomeNews extends StatelessWidget {
  final data;

  HomeNews({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * (30 / 100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (ctx, i) => RecommendedNews(
          post: null,
        ),
      ),
    );
  }
}
