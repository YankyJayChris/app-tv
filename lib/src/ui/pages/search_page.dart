import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/src/models/api_result_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:newsapp/src/models/article.dart';
import 'package:newsapp/src/models/search_video.dart';
import 'package:newsapp/src/models/video.dart';
import 'package:newsapp/src/resources/strings.dart';
import 'package:newsapp/src/ui/widgets/vertical_items.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<Article> _results = List();
  List<Video> _resultsideos = List();
  List<bool> isSelected;
  int tab;

  Timer debounceTimer;

  _SearchPageState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  Future<List<Article>> _getALlPosts(String text) async {
    var response = await http
        .get(AppStrings.primeURL + '?type=fetch_articles&keyword=$text');
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Article> articles = ApiResultModel.fromJson(data).data;
      return articles;
    } else {
      throw Exception('error fetching articles');
    }
  }

  Future<List<Video>> _getALlVideos(String text) async {
    var response = await http
        .get(AppStrings.primeURL + '?type=search_videos&keyword=$text');
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Video> videos = SearchVideoModel.fromJson(data).data;
      return videos;
    } else {
      throw Exception('error fetching articles');
    }
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final repos = await _getALlPosts(query);
    final reposvideo = await _getALlVideos(query);
    if (this._searchQuery.text == query && this.mounted) {
      setState(() {
        _isSearching = false;
        if (repos != null) {
          _results = repos;
          _resultsideos = reposvideo;
        } else {
          _error = 'No article found';
        }
      });
    }
  }

  @override
  void initState() {
    isSelected = [true, false];
    tab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: AppBar(
          centerTitle: true,
          title: TextField(
            autofocus: false,
            controller: _searchQuery,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(end: 16.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
                hintText: "Search Articles...",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(
          children: [
            buildBody(context),
          ],
        ));
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching tv1 news...');
    } else if (_error != null) {
      return CenterTitle('Nothing found please search again');
    } else if (_searchQuery.text.isEmpty) {
      return CenterTitle('Search the news');
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _results.length,
              itemBuilder: (BuildContext context, int index) {
                return RowItem(post: _results[index]);
              }),
        ),
      );
    }
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    print(message);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.green[900]),
        ),
      ),
    );
  }

  ListView buildNewsListView(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, i) => RowItem(post: articles[i]),
    );
  }

  Widget toggle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ToggleButtons(
          borderColor: Colors.black,
          fillColor: Colors.grey,
          borderWidth: 2,
          selectedBorderColor: Colors.black,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Open 24 Hours',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Custom Hours',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
              tab = index;
            });
          },
          isSelected: isSelected,
        ),
      ],
    );
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        ));
  }
}
