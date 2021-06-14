import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/article/bloc.dart';
import '../../../src/models/article.dart';
import '../../../src/ui/widgets/bottom_loder.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/ui/widgets/recommended_news.dart';
import '../../../src/ui/widgets/vertical_items.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  final _scrollThreshold = 200.0;
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _articleBloc.add(ArticleFetched());
    }
  }

  Future<Null> _refreshPage() async {
    BlocProvider.of<ArticleBloc>(context).add(ArticleRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () {
                  Navigator.pushNamed(context, '/searchpage');
                },
                child: Icon(Icons.search, color: Colors.black),
              ),
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
        onRefresh: _refreshPage,
        child: SingleChildScrollView(
          controller: _scrollController,
          child:
              BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
            if (state is ArticleFailure) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text('Pull down to refresh'),
                ),
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
              return Column(
                children: <Widget>[
                  HeaderSection(title: "Latest News", route: "news"),
                  buildLatestVideo(state.articles),
                  HeaderSection(title: "Recently News", route: " "),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child:
                        buildVideoListView(state.articles, state.hasReachedMax),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
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
          style: TextStyle(color: Colors.purple[800]),
        ),
      ),
    );
  }

  ListView buildVideoListView(List<Article> articles, bool hasReachedMax) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= articles.length
            ? BottomLoader()
            : RowItem(post: articles[index]);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hasReachedMax ? articles.length : articles.length + 1,
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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../src/blocs/article/bloc.dart';
// import '../../../src/blocs/categories/bloc.dart';
// import '../../../src/models/article.dart';
// import '../../../src/models/category.dart';
// import '../../../src/ui/widgets/bottom_loder.dart';
// import '../../../src/ui/widgets/header_section.dart';
// import '../../../src/ui/widgets/recommended_news.dart';
// import '../../../src/ui/widgets/vertical_items.dart';

// class NewsPage extends StatefulWidget {
//   NewsPage({Key key}) : super(key: key);

//   @override
//   _NewsPageState createState() => _NewsPageState();
// }

// class _NewsPageState extends State<NewsPage>
//     with SingleTickerProviderStateMixin {
//   TabController _tabControler;
//   ScrollController _scrollViewController;
//   CategoryBloc _categoryBloc;
//   var categories;
//   // List<Category> categories;

//   @override
//   void initState() {
//     super.initState();
//     _categoryBloc = BlocProvider.of<CategoryBloc>(context);
//     setState(() {
//       categories = _categoryBloc.state;
//     });
//     print(categories.toString());
//     _tabControler = TabController(vsync: this, initialIndex: 1, length: 6);
//     _scrollViewController = ScrollController();
//     _tabControler.addListener(_handleTabSelection);
//   }

//   void _handleTabSelection() {
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _tabControler.dispose();
//     _scrollViewController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoriesState>(
//         builder: (context, state) {
//       return DefaultTabController(
//         length: state.categories,
//         child: Scaffold(
//           body: NestedScrollView(
//             controller: _scrollViewController,
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                   automaticallyImplyLeading: false,
//                   backgroundColor: Colors.white,
//                   title: Row(
//                     children: <Widget>[
//                       Image.asset(
//                         'assets/images/logo_44.png',
//                         width: 100,
//                         height: 200,
//                       ),
//                       SizedBox(
//                         width: 5.0,
//                       ),
//                     ],
//                     mainAxisAlignment: MainAxisAlignment.start,
//                   ),
//                   floating: true,
//                   pinned: true,
//                   snap: true,
//                   bottom: TabBar(
//                     isScrollable: true,
//                     unselectedLabelColor: Colors.purple[800].withOpacity(0.3),
//                     indicatorColor: Colors.purple[800],
//                     tabs: [
//                       Tab(
//                         child: Text(
//                           'Tab 1',
//                           style: TextStyle(
//                             color: _tabControler.index == 0
//                                 ? Colors.purple[800]
//                                 : Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           'Tab 2',
//                           style: TextStyle(
//                             color: _tabControler.index == 1
//                                 ? Colors.purple[800]
//                                 : Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           'Tab 3',
//                           style: TextStyle(
//                             color: _tabControler.index == 2
//                                 ? Colors.purple[800]
//                                 : Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           'Tab 4',
//                           style: TextStyle(
//                             color: _tabControler.index == 3
//                                 ? Colors.purple[800]
//                                 : Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           'Tab 5',
//                           style: TextStyle(
//                             color: _tabControler.index == 4
//                                 ? Colors.purple[800]
//                                 : Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           'Tab 6',
//                           style: TextStyle(
//                             color: _tabControler.index == 5
//                                 ? Colors.purple[800]
//                                 : Colors.black,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       )
//                     ],
//                     controller: _tabControler,
//                   ),
//                   actions: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/sendvideo');
//                           },
//                           child: Icon(
//                             Icons.videocam,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(width: 15),
//                         GestureDetector(
//                             onTap: () {
//                               Navigator.pushNamed(context, '/searchpage');
//                             },
//                             child: Icon(Icons.search, color: Colors.black)),
//                         SizedBox(width: 15),
//                       ],
//                       mainAxisAlignment: MainAxisAlignment.end,
//                     )
//                   ],
//                 ),
//               ];
//             },
//             body: TabBarView(controller: _tabControler, children: [
//               Container(
//                 child: Center(
//                   child: Text('Tab 1'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 2'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 3'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 4'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 5'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 6'),
//                 ),
//               ),
//             ] // <--- the array item is a ListView
//                 ),
//           ),
//         ),
//       );
//     });
//   }
// }
