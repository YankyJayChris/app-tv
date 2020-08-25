import 'package:flutter/material.dart';

import 'package:newsapp/src/models/models.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';
import 'package:html_unescape/html_unescape.dart';


// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/html_parser.dart';
// import 'package:flutter_html/style.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article post;
  ArticleDetailScreen({this.post});

  @override
  ArticleDetailScreenState createState() => ArticleDetailScreenState();
}

class ArticleDetailScreenState extends State<ArticleDetailScreen> {
  var unescape = new HtmlUnescape();
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
      body: Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: SingleChildScrollView(
          child: HtmlTextView(
            data: "${unescape.convert(widget.post.orginalText)}",
            anchorColor: Colors.purple[800],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nested(),
    );
  }
}
