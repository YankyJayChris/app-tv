import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:newsapp/src/ui/pages/home_page.dart';
import 'package:newsapp/src/ui/pages/news_page.dart';
import 'package:newsapp/src/ui/pages/profile_page.dart';
import 'package:newsapp/src/ui/pages/search_page.dart';
import 'package:newsapp/src/ui/pages/video_page.dart';

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

    _messaging.subscribeToTopic('news');
    if (Platform.isIOS) {
      iosSubscription = _messaging.onIosSettingsRegistered.listen((data) {
        _messaging.subscribeToTopic('news');
      });

      _messaging.requestNotificationPermissions(IosNotificationSettings());
    }

    currentPage = pages[widget.tabIndex];
    currentTab = widget.tabIndex;
    _saveDeviceToken();
    super.initState();
  }

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    String fcmToken = await _messaging.getToken();

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
            
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            // TODO optional
        },
      );
  }

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
              title: Text(''),
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
