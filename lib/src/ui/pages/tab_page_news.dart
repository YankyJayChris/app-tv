import 'dart:math';

import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Featured",
    "Popular",
    "Latest",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      title: const Text('Books'),
                      floating: true,
                      pinned: true,
                      snap: false,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                    child: Center(child: Text("hi my frind"),),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}