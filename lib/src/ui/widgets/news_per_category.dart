import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/api_result_model.dart';

import 'package:newsapp/src/models/article.dart';
import 'package:newsapp/src/resources/strings.dart';
import 'package:newsapp/src/ui/widgets/vertical_items.dart';

class CatBuilder extends StatelessWidget {
  final String catId;

  CatBuilder({this.catId});

  @override
  Widget build(BuildContext context) {
    return _catPostsData(catId);
  }

  Future<List<Article>> _getCatPosts(String text) async {
    var response = await http
        .get(AppStrings.primeURL + '?type=fetch_articles&category_id=$text');
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Article> articles = ApiResultModel.fromJson(data).data;
      return articles;
    } else {
      throw Exception('error fetching articles');
    }
  }

  FutureBuilder _catPostsData(String catId) {
    return FutureBuilder<List<Article>>(
      future: _getCatPosts(catId),
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        List<Article> data = snapshot.data;
        if (data == null) {
          return Center(child: CircularProgressIndicator());
        } else if (data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * (95 / 100),
                  height: MediaQuery.of(context).size.height * (25 / 100),

                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/images/emptyState.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("This category has no news yet"),
              ],
            ),
          );
        } else if (data != null) {
          List<Article> data = snapshot.data;
          return _buildBody(data);
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView _buildBody(data) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return RowItem(post: data[index]);
        });
  }
}
