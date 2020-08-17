import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/article/article_state.dart';
import 'package:newsapp/src/blocs/article/bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/models/article.dart';
import 'package:newsapp/src/models/video.dart';
import 'package:newsapp/src/ui/widgets/categories.dart';
import 'package:newsapp/src/ui/widgets/header_section.dart';
import 'package:newsapp/src/ui/widgets/recommended_news.dart';
import 'package:newsapp/src/ui/widgets/top_banner.dart';
import 'package:newsapp/src/ui/widgets/LatestVideo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                    Navigator.pushNamed(context, '/sendvideo');
                  },
                  child: Icon(
                    Icons.videocam,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                    onTap: () {},
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
        body: RefreshIndicator(
          onRefresh: () {
            return null;
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * (30 / 100),
                    width: double.infinity,
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
                        return CarouselSlider.builder(
                            height:
                                MediaQuery.of(context).size.height * (30 / 100),
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 1000),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            pauseAutoPlayOnTouch: Duration(seconds: 5),
                            viewportFraction: 1.0,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int itemIndex) {
                              List<Video> latest = state.latest;
                              return TopBanner(video: latest[itemIndex]);
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1, 2, 3, 4].map((i) {
                    int index = i;
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Colors.purple[800]
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  }).toList(),
                ),
                HeaderSection(title: "Category", route: "category"),
                CategoriesWidget(),
                HeaderSection(title: "Latest News", route: "news"),
                // LatestVideoWidget(),
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
                  }),
                ),
                HeaderSection(title: "Top Videos", route: " "),
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
                      return LatestVideoWidget(data: state.top);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
              ],
            ),
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
}
