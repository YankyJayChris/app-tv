import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newsapp/src/blocs/auth/bloc.dart';
import 'package:newsapp/src/blocs/categories/bloc.dart';
import 'package:newsapp/src/blocs/payment/bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/models/userRepo.dart';
import 'package:newsapp/src/models/video.dart';
import 'package:newsapp/src/repository/local_data.dart';
import 'package:newsapp/src/resources/strings.dart';

import 'package:newsapp/src/ui/pages/home_page.dart';
import 'package:newsapp/src/ui/pages/news_page.dart';
import 'package:newsapp/src/ui/pages/profile_page.dart';
import 'package:newsapp/src/ui/pages/search_page.dart';
import 'package:newsapp/src/ui/pages/video_page.dart';
import 'package:overlay_support/overlay_support.dart';

class TabScreen extends StatefulWidget {
  final int tabIndex;

  TabScreen({
    Key key,
    this.tabIndex = 0,
  }) : super(key: key);
  @override
  TabScreenState createState() => new TabScreenState();
}

class TabScreenState extends State<TabScreen> {
  final Key keyNews = PageStorageKey('pageNews');
  final Key keysearch = PageStorageKey('pageSearch');
  final Key keyHome = PageStorageKey('pageHome');
  final Key keyVideos = PageStorageKey('pageVideos');
  final Key keyProfile = PageStorageKey('pageProfile');
  VideoBloc _videoBloc;
  String _ip = 'Unknown';

  final FirebaseMessaging _messaging = FirebaseMessaging();
  final Firestore _db = Firestore.instance;

  int currentTab = 1;

  VideoPage myVideos;
  HomePage home;
  NewsPage myNews;
  SearchPage search;
  ProfilePage profile;
  List<Widget> pages;
  Widget currentPage;
  StreamSubscription iosSubscription;
  String _appBadgeSupported = 'Unknown';
  LocalData prefs = LocalData();
  UserRespoModel userData;
  AuthenticationBloc _authenticationBloc;
  PaymentsBloc _paymentBloc;
  CategoryBloc _categoryBloc;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    myNews = NewsPage(
      key: keyNews,
    );
    myVideos = VideoPage(
      key: keyVideos,
    );
    home = HomePage(
      key: keyHome,
    );
    search = SearchPage(
      key: keysearch,
    );
    profile = ProfilePage(
      key: keyProfile,
    );

    pages = [home, search, myNews, myVideos, profile];
    _videoBloc = BlocProvider.of<VideoBloc>(context);
    _paymentBloc = BlocProvider.of<PaymentsBloc>(context);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _messaging.subscribeToTopic('news');
    if (Platform.isIOS) {
      iosSubscription = _messaging.onIosSettingsRegistered.listen((data) {
        _messaging.subscribeToTopic('news');
      });

      _messaging.requestNotificationPermissions(IosNotificationSettings());
    }
    _checkLogin();
    _saveDeviceToken();
    // _refreshPaymentPage();
    currentPage = pages[widget.tabIndex];
    currentTab = widget.tabIndex;
    super.initState();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    String fcmToken = await _messaging.getToken();
    print(fcmToken);

    if (fcmToken != null) {
      var tokens = _db
          .collection('devices')
          .document(fcmToken)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var view = message['data']['type'];
        var post = message['data']['post'];
        print("onMessage: $post");
        _showNotification(message['notification']['title'],
            message['notification']['body'], view, post);
        _addBadge();
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _serialiseAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _serialiseAndNavigate(message);
      },
    );
  }

  void _showNotification(title, body, view, post) {
    showOverlayNotification(
      (context) {
        print("inside notification ======");
        return GestureDetector(
          onTap: () {
            if (view == 'video') {
              Video video = Video.fromJson(jsonDecode(post));
              video.thumbnail = AppStrings.mainURL + video.thumbnail;
              video.videoLocation = AppStrings.mainURL + video.videoLocation;
              video.owner.avatar = AppStrings.mainURL + video.owner.avatar;
              print(video.owner.avatar);
              OverlaySupportEntry.of(context).dismiss();
              Navigator.pushNamed(context, '/videodetail', arguments: video);
            }
            if (view == 'article') {
              OverlaySupportEntry.of(context).dismiss();
              Navigator.pushNamed(context, '/articledetail', arguments: post);
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(
                        child: Container(
                      color: Colors.purple[800],
                      child: (view == 'video')
                          ? Icon(
                              Icons.video_library,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.library_books,
                              color: Colors.white,
                            ),
                    ))),
                title: Text(title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                    maxLines: 2),
                subtitle: Text(body,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    textAlign: TextAlign.start,
                    maxLines: 2),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          ),
        );
      },
      duration: Duration(seconds: 10),
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var view = message['data']['type'];
    var post = message['data']['post'];
    print("onLaunch: $view");

    if (view != null) {
      // Navigate to the create post view
      if (view == 'video') {
        Video video = Video.fromJson(jsonDecode(post));
        video.thumbnail = AppStrings.mainURL + video.thumbnail;
        video.videoLocation = AppStrings.mainURL + video.videoLocation;
        video.owner.avatar = AppStrings.mainURL + video.owner.avatar;
        print(video.owner.avatar);
        Navigator.pushNamed(context, '/videodetail', arguments: video);
      }
      if (view == 'article') {
        Navigator.pushNamed(context, '/articledetail', arguments: post);
      }
      // If there's no view it'll just open the app on the first view
    }
  }

  _badgeState() async {
    String appBadgeSupported;

    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

  void _addBadge() {
    Future<int> noNum = prefs.getsubNotNumber();
    int number = 0;
    noNum.then((data) {
      number = data + 1;
    });
    if (number > 0) {
      prefs.setsubNotNumber(number);
      FlutterAppBadger.updateBadgeCount(number);
      print(_appBadgeSupported);
    }
  }

  void _removeBadge() {
    FlutterAppBadger.removeBadge();
  }

  _checkLogin() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    Future<String> userLocal = prefs.getuserData();
    userLocal.then((data) {
      UserRespoModel userData =
          UserRespoModel.fromJson(jsonDecode(data.toString()));
      BlocProvider.of<AuthenticationBloc>(context)
          .add(Autheticated(userData: userData));
          BlocProvider.of<PaymentsBloc>(context)
        .add(CheckPayStatus(s: userData.data.sessionId, userId: "${userData.data.userId}"));
    }, onError: (e) {
      print(e);
    });
  }

  // Future<Null> _refreshPaymentPage() async {
  //   BlocProvider.of<PaymentsBloc>(context)
  //       .add(CheckPayStatus(s: "ahfshdfhdsfds", userId: "3"));
  // }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        currentTab = index;
        currentPage = pages[index];
      });
    }

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTabTapped,
          currentIndex: currentTab,
          fixedColor: Colors.purple[800],
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentTab == 0 ? Colors.purple[800] : Colors.black,
                size: 23.0,
              ),
              title: currentTab == 0 ? Text('Home') : Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: currentTab == 1 ? Colors.purple[800] : Colors.black,
                size: 23.0,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                color: currentTab == 2 ? Colors.purple[800] : Colors.black,
                size: 23.0,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.video_library,
                color: currentTab == 3 ? Colors.purple[800] : Colors.black,
                size: 23.0,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.supervised_user_circle,
                color: currentTab == 4 ? Colors.purple[800] : Colors.black,
                size: 23.0,
              ),
              title: Text(''),
            )
          ]),
    );
  }
}
