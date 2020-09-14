import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:newsapp/src/models/models.dart';
import 'package:flutter_html_textview_render/html_text_view.dart';
import 'package:html_unescape/html_unescape.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/repository/article_api.dart';
import 'package:newsapp/src/resources/strings.dart';



// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/html_parser.dart';
// import 'package:flutter_html/style.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String postId;
  ArticleDetailScreen({this.postId});

  @override
  ArticleDetailScreenState createState() => ArticleDetailScreenState();
}

class ArticleDetailScreenState extends State<ArticleDetailScreen> {
  var unescape = new HtmlUnescape();
  nested(post) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${post.title}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              background: Image.network(
                "${post.image}",
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
            data: "${unescape.convert(post.orginalText)}",
            anchorColor: Colors.purple[800],
          ),
        ),
      ),
    );
  }
  FutureBuilder _buildscreen(String postId){
    return FutureBuilder<Article>(
      future: getpost(postId),
      builder: (BuildContext context, AsyncSnapshot<Article> snapshot){
        if (snapshot.hasData) {
          Article data = snapshot.data;
          return nested(data);
        } else if (snapshot.hasError) {
          return CenterTitle("Nothing found");
        }
        return CenterIndicator();
      },
    );
  }

  Future<Article> getpost(String id) async {
    var response = await http
        .get(AppStrings.primeURL + '?type=get_article&article_id=$id');
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Article articles = ArticleApi.fromJson(data).data;
      return articles;
    } else {
      throw Exception('error fetching articles');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildscreen(widget.postId),
    );
  }
}


class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Getting Article"),
        ),
          body: Container(
          alignment: Alignment.center,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            children: [
              Center(
                child: Image.asset(
                  'assets/images/search-icon.png',
                  width: 500,
                  height: 500,
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}
class CenterIndicator extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Getting Article"),
        ),
          body: Container(
          alignment: Alignment.center,
          child: Center(
            child: CircularProgressIndicator(),
          ),
    ),);
  }
}
