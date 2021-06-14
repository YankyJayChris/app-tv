import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/article/article_state.dart';
import '../../../src/blocs/article/bloc.dart';
import '../../../src/blocs/video/bloc.dart';
import '../../../src/blocs/video_categories/bloc.dart';
import '../../../src/blocs/categories/bloc.dart';
import '../../../src/models/article.dart';
import '../../../src/models/video.dart';
import '../../../src/ui/widgets/categories.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/ui/widgets/recommended_news.dart';
import '../../../src/ui/widgets/top_banner.dart';
import '../../../src/ui/widgets/LatestVideo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  // VideoBloc _videoBloc;
  // ArticleBloc _articleBloc;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Future<Null> _refreshPage() async {
    BlocProvider.of<ArticleBloc>(context).add(ArticleRefresh());
    BlocProvider.of<VideoBloc>(context).add(VideoRefresh());
    BlocProvider.of<CategoryBloc>(context).add(CategoriesRefresh());
    BlocProvider.of<VidCategoryBloc>(context).add(VidCategoriesRefresh());
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
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/camera');
                  },
                  child: Icon(
                    Icons.file_upload,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/tv');
                  },
                  child: Icon(
                    Icons.live_tv,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
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
                // Stack(
                //   children: <Widget>[
                //     new IconButton(
                //         icon: Icon(Icons.notifications, color: Colors.black),
                //         onPressed: () {}),
                //     2 != 0
                //         ? new Positioned(
                //             right: 11,
                //             top: 11,
                //             child: new Container(
                //               padding: EdgeInsets.all(2),
                //               decoration: new BoxDecoration(
                //                 color: Colors.red,
                //                 borderRadius: BorderRadius.circular(6),
                //               ),
                //               constraints: BoxConstraints(
                //                 minWidth: 14,
                //                 minHeight: 14,
                //               ),
                //               child: Text(
                //                 '2',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 8,
                //                 ),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ),
                //           )
                //         : new Container()
                //   ],
                // ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshPage,
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
                          child: Text('Pull down to refresh'),
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
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height *
                                  (30 / 100),
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1000),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              // pauseAutoPlayOnTouch: Duration(seconds: 5),
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                            itemCount: state.latest.length < 5
                                ? state.latest.length
                                : 5,
                            itemBuilder: (ctx, index, realIdx) {
                              List<Video> latest = state.latest;
                              return TopBanner(video: latest[index]);
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                ),
                Container(
                  child: BlocBuilder<VideoBloc, VideoState>(
                      builder: (context, state) {
                    if (state is VideoFailure) {
                      return Center(
                        child: Container(),
                      );
                    }
                    if (state is VideoSuccess) {
                      if (state.latest.isEmpty) {
                        return Center(
                          child: Container(),
                        );
                      }
                    }
                    if (state is VideoSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            state.latest.length < 5 ? state.latest.length : 5,
                            (i) {
                          int index = i;
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.purple[800]
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: Container(),
                    );
                  }),
                ),
                // HeaderSection(title: "Category", route: "category"),
                CategoriesWidget(),
                HeaderSection(title: "Latest News", route: "news"),
                Container(
                  height: MediaQuery.of(context).size.height * (30 / 100),
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                    if (state is ArticleFailure) {
                      return Center(
                        child: Text('Pull down to refresh'),
                      );
                    }
                    if (state is ArticleSuccess) {
                      if (state.articles.isEmpty) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Center(
                            child: Text('no Articles found'),
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
                        child: Text('Pull down to refresh'),
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
