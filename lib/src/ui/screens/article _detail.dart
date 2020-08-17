import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:flutter_html_textview_render/html_text_view.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';

import 'package:newsapp/src/models/models.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article post;
  ArticleDetailScreen({this.post});

  @override
  ArticleDetailScreenState createState() => ArticleDetailScreenState();
}

class ArticleDetailScreenState extends State<ArticleDetailScreen> {
  nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "${widget.post.title}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Image.network(
                "${widget.post.image}",
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "${widget.post.orginalText}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
      // body: Container(
      //     margin: EdgeInsets.all(16.0),
      //     child: HtmlTextView(
      //       data: "<div style='color: #0000ff'>${widget.post.orginalText}</div>",
      //       anchorColor: Color(0xFFFF0000),
      //     ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nested(),
    );
  }
}
