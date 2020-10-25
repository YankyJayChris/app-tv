// import 'package:chewie/chewie.dart';
// import 'package:chewie/src/chewie_player.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/article/bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/models/article.dart';
import 'package:newsapp/src/ui/widgets/header_section.dart';
import 'package:newsapp/src/ui/widgets/LatestVideo.dart';
import 'package:newsapp/src/ui/widgets/recommended_news.dart';

import 'package:screen/screen.dart';

class TvScreen extends StatefulWidget {
  TvScreen({Key key}) : super(key: key);

  @override
  _TvScreenState createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  final FijkPlayer player = FijkPlayer();
  bool _isKeptOn = true;
  double _brightness = 1.0;
  static const FijkFit cover = FijkFit(
    sizeFactor: 1.0,
    aspectRatio: double.infinity,
    alignment: Alignment.center,
  );

  @override
  void initState() {
    super.initState();
    player.setDataSource("rtmp://80.241.215.175:1935/tv1rwanda/tv1rwanda",
        autoPlay: true);

    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  initPlatformState() async {
    Screen.keepOn(_isKeptOn);
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState(() {
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  Future<Null> _refreshPage() async {
    player.setDataSource("rtmp://80.241.215.175:1935/tv1rwanda/tv1rwanda",
        autoPlay: true);

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/logo_44.png',
                width: 100,
                height: 200,
              ),
              SizedBox(
                width: 5.0,
              ),
              // Text(
              //   'TV1 PRIME',
              //   style: TextStyle(color: Colors.black, fontFamily: 'BebasNeue'),
              // ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    player.release();
                    Navigator.pop(context);
                  Navigator.pushNamed(context, '/radio');

                 },
                  child: Icon(
                    Icons.radio,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                    onTap: () {
                      
                      Navigator.pushNamed(context, '/searchpage');
                    },
                    child: Icon(Icons.search, color: Colors.black)),
                SizedBox(width: 15),
                // GestureDetector(
                //   onTap: () {},
                //   child: Image.asset(
                //     'assets/icons/user.png',
                //     width: 40,
                //     height: 30,
                //   ),
                // )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: _refreshPage,
          child:Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * (30 / 100),
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: FijkView(
                    player: player,
                    fit: cover,
                    fsFit: cover,
                    height: MediaQuery.of(context).size.height * (30 / 100),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      HeaderSection(title: "Latest News", route: "news"),
                      Container(
                          height: MediaQuery.of(context).size.height * (30 / 100),
                          child: BlocBuilder<ArticleBloc, ArticleState>(
                              builder: (context, state) {
                            if (state is ArticleFailure) {
                              return Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Center(
                                  child: Text('failed to fetch Videos'),
                                ),
                              );
                            }
                            if (state is ArticleSuccess) {
                              if (state.articles.isEmpty) {
                                return Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Center(
                                    child: Text('no video found'),
                                  ),
                                );
                              }
                            }
                            if (state is ArticleSuccess) {
                              return buildLatestVideo(state.articles);
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          })),
                      HeaderSection(title: "Latest Video", route: " "),
                      Container(
                        height: MediaQuery.of(context).size.height * (30 / 100),
                        child: BlocBuilder<VideoBloc, VideoState>(
                            builder: (context, state) {
                          if (state is VideoFailure) {
                            return Center(
                              child: Text('failed to fetch Videos'),
                            );
                          }
                          if (state is VideoSuccess) {
                            if (state.latest.isEmpty) {
                              return Center(
                                child: Text('no video found'),
                              );
                            }
                          }
                          if (state is VideoSuccess) {
                            return LatestVideoWidget(data: state.latest);
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLatestVideo(List<Article> articles) {
    return Container(
      height: MediaQuery.of(context).size.height * (30 / 100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length < 5 ? articles.length : 5,
        itemBuilder: (ctx, i) => RecommendedNews(post: articles[i]),
      ),
    );
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
}
