import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/categories/bloc.dart';
import 'package:newsapp/src/models/category.dart';
import 'package:newsapp/src/ui/pages/home_videos_page.dart';
import 'package:newsapp/src/ui/widgets/videos_per_category.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Material(
      child: Scaffold(
        body: BlocBuilder<CategoryBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesSuccess) {
              _tabController = new TabController(vsync: this, length: state.categories.length);
              _tabController.animateTo(0);
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
                              controller: _tabController,
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
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(
                                  //         context, '/sendvideo');
                                  //   },
                                  //   child: Icon(
                                  //     Icons.videocam,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                  // SizedBox(width: 15),
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
                    controller: _tabController,
                    children: state.categories.map((Category category) {
                      return SafeArea(
                        top: false,
                        bottom: false,
                        child: (category.id == 0)
                            ? HomeBuilderVideoPage()
                            : VideoCatBuilder(catId:category.langKey ,),
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

}
