import 'package:flutter/material.dart';
import 'package:newsapp/src/ui/screens/article%20_detail.dart';
import 'package:newsapp/src/ui/screens/radio_screen.dart';
import 'package:newsapp/src/ui/screens/report_news.dart';
import 'package:newsapp/src/ui/screens/take_video.dart';
import 'package:newsapp/src/ui/screens/trending_screen.dart';
import 'package:newsapp/src/ui/screens/tv_screen.dart';
import 'package:newsapp/src/ui/auth/signin_page.dart';
import 'package:newsapp/src/ui/auth/signup_page.dart';
import 'package:newsapp/src/ui/tabbar.dart';
import 'package:newsapp/src/ui/widgets/text.dart';

import '../ui/screens/video_detail.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => TabScreen());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SigninPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/tv':
        return MaterialPageRoute(builder: (_) => TvScreen());
      case '/radio':
        return MaterialPageRoute(builder: (_) => RadioScreen());
      case '/report':
        return MaterialPageRoute(builder: (_) => ReportScreen());
      case '/trending':
        return MaterialPageRoute(builder: (_) => TrendingScreen());
      case '/videodetail':
        return MaterialPageRoute(builder: (_) => VideoDetailScreen(video: args));
      case '/articledetail':
        // return MaterialPageRoute(builder: (_) => ArticleDetailScreen(post: args));
        return MaterialPageRoute(builder: (_) => TextScrenn());
      case '/sendvideo':
        return MaterialPageRoute(builder: (_) => SendVideo());
      default:
        return MaterialPageRoute(builder: (_) => TabScreen());
    }
  }

}