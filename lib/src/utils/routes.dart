import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/repository/user_repository.dart';
import 'package:newsapp/src/ui/pages/search_page.dart';
import 'package:newsapp/src/ui/screens/article_detail.dart';
import 'package:newsapp/src/ui/screens/new_onboarding.dart';
// import 'package:newsapp/src/ui/screens/login_page.dart';
import 'package:newsapp/src/ui/screens/onboarding.dart';
import 'package:newsapp/src/ui/screens/otp_page.dart';
import 'package:newsapp/src/ui/screens/otp_page_news.dart';
import 'package:newsapp/src/ui/screens/phone_login.dart';
import 'package:newsapp/src/ui/screens/radio_screen.dart';
import 'package:newsapp/src/ui/screens/report_news.dart';
import 'package:newsapp/src/ui/screens/take_video.dart';
import 'package:newsapp/src/ui/screens/trending_screen.dart';
import 'package:newsapp/src/ui/screens/tv_screen.dart';
import 'package:newsapp/src/ui/auth/signup_page.dart';
import 'package:newsapp/src/ui/tabbar.dart';

import '../ui/screens/video_detail.dart';


class RouteGenerator {

  static final userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);
      
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => TabScreen(tabIndex: (args != null)?args:0,));
      case '/signin':
        return MaterialPageRoute(builder: (_) => PhoneLoginPage());
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
        return MaterialPageRoute(builder: (_) => ArticleDetailScreen(post: args));
      case '/sendvideo':
        return MaterialPageRoute(builder: (_) => SendVideo());
      case '/searchpage':
        return MaterialPageRoute(builder: (_) => SearchPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => Onboarding());
      case '/otpPage':
        return MaterialPageRoute(builder: (_) => OtpPagenew(mobileNumber: args));
      default:
        return MaterialPageRoute(builder: (_) => TabScreen());
    }
  }

}