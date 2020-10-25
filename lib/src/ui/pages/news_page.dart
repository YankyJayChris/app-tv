// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapp/src/blocs/article/bloc.dart';
// import 'package:newsapp/src/models/article.dart';
// import 'package:newsapp/src/ui/widgets/bottom_loder.dart';
// import 'package:newsapp/src/ui/widgets/header_section.dart';
// import 'package:newsapp/src/ui/widgets/recommended_news.dart';
// import 'package:newsapp/src/ui/widgets/vertical_items.dart';

// class NewsPage extends StatefulWidget {
//   NewsPage({Key key}) : super(key: key);

//   @override
//   _NewsPageState createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage> {
//   final _scrollController = ScrollController(initialScrollOffset: 0.0);
//   final _scrollThreshold = 200.0;
//   ArticleBloc _articleBloc;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _articleBloc = BlocProvider.of<ArticleBloc>(context);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     if (maxScroll - currentScroll <= _scrollThreshold) {
//       _articleBloc.add(ArticleFetched());
//     }
//   }

//   Future<Null> _refreshPage() async {
//     BlocProvider.of<ArticleBloc>(context).add(ArticleRefresh());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         title: Row(
//           children: <Widget>[
//             Image.asset(
//               'assets/images/logo_44.png',
//               width: 100,
//               height: 200,
//             ),
//             SizedBox(
//               width: 5.0,
//             ),
//             // Text(
//             //   'TV1 PRIME',
//             //   style: TextStyle(color: Colors.black, fontFamily: 'BebasNeue'),
//             // ),
//           ],
//           mainAxisAlignment: MainAxisAlignment.start,
//         ),
//         actions: <Widget>[
//           Row(
//             children: <Widget>[
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/sendvideo');
//                 },
//                 child: Icon(
//                   Icons.videocam,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(width: 15),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushNamed(context, '/searchpage');
//                 },
//                 child: Icon(Icons.search, color: Colors.black),
//               ),
//               SizedBox(width: 15),
//               // GestureDetector(
//               //   onTap: () {},
//               //   child: Image.asset(
//               //     'assets/icons/user.png',
//               //     width: 40,
//               //     height: 30,
//               //   ),
//               // )
//             ],
//             mainAxisAlignment: MainAxisAlignment.end,
//           )
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshPage,
//         child: SingleChildScrollView(
//           controller: _scrollController,
//           child:
//               BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
//             if (state is ArticleFailure) {
//               return Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 child: Center(
//                   child: Text('Pull down to refresh'),
//                 ),
//               );
//             }
//             if (state is ArticleSuccess) {
//               if (state.articles.isEmpty) {
//                 return Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   child: Center(
//                     child: Text('no Articles found'),
//                   ),
//                 );
//               }
//             }
//             if (state is ArticleSuccess) {
//               return Column(
//                 children: <Widget>[
//                   HeaderSection(title: "Latest News", route: "news"),
//                   buildLatestVideo(state.articles),
//                   HeaderSection(title: "Recently News", route: " "),
//                   Container(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child:
//                         buildVideoListView(state.articles, state.hasReachedMax),
//                   ),
//                 ],
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//         ),
//       ),
//     );
//   }

//   Widget buildLoading() {
//     return Center(
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget buildErrorUi(String message) {
//     print(message);
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           message,
//           style: TextStyle(color: Colors.purple[800]),
//         ),
//       ),
//     );
//   }

//   ListView buildVideoListView(List<Article> articles, bool hasReachedMax) {
//     return ListView.builder(
//       itemBuilder: (BuildContext context, int index) {
//         return index >= articles.length
//             ? BottomLoader()
//             : RowItem(post: articles[index]);
//       },
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: hasReachedMax ? articles.length : articles.length + 1,
//     );
//   }

//   Widget buildLatestVideo(List<Article> articles) {
//     return Container(
//       height: MediaQuery.of(context).size.height * (30 / 100),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: articles.length < 5 ? articles.length : 5,
//         itemBuilder: (ctx, i) => RecommendedNews(post: articles[i]),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/blocs/categories/bloc.dart';
import 'package:newsapp/src/models/category.dart';
import 'package:newsapp/src/resources/strings.dart';
import 'package:newsapp/src/ui/pages/home_widget.dart';
import 'package:newsapp/src/ui/widgets/home_news.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> listItems = [];
  List<Category> categories;

  final List<String> _tabs = <String>[
    "Featured",
    "Popular",
    "Latest",
    "Latest",
    "Latest",
    "Latest",
    "Latest",
    "Latest",
  ];
  Future<List> _fetchCategories() async {
    final response =
        await http.get(AppStrings.primeURL + '?type=get_categories');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // print(data);
      List<Category> mycategories = CategoriesRepo.fromJson(data).categoryies;
      setState(() {
        categories = mycategories;
      });
      return mycategories;
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: BlocBuilder<CategoryBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesSuccess) {
              return DefaultTabController(
                length: state.categories.length,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverSafeArea(
                          top: false,
                          sliver: SliverAppBar(
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
                            floating: true,
                            pinned: true,
                            snap: false,
                            primary: true,
                            forceElevated: innerBoxIsScrolled,
                            bottom: TabBar(
                              isScrollable: true,
                              unselectedLabelColor: Colors.black,
                              indicatorColor: Colors.purple[800],
                              tabs: state.categories
                                  .map(
                                    (Category category) => Tab(
                                      child: Text(
                                        category.english,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            actions: <Widget>[
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/sendvideo');
                                    },
                                    child: Icon(
                                      Icons.videocam,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/searchpage');
                                      },
                                      child: Icon(Icons.search,
                                          color: Colors.black)),
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
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: state.categories.map((Category category) {
                      return SafeArea(
                        top: false,
                        bottom: false,
                        child:(category.id == 0)? HomeBuilderPage(): Container(
                          child: Center(
                            child: Text(category.english),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _buildTabs(List<Category> categories) {
    Category main = Category(id: 0,langKey: "All",english:"Home",type: "category");
    categories.insert(0, main);
    return categories.map(
          (Category category) => Tab(
            child: Text(
              category.english,
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
        .toList();
  }
}
