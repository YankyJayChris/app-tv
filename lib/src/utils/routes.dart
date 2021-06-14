import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/ui/pages/backups/custom_gallery.dart';
import 'package:newsapp/src/ui/pages/gallery.dart';
import '../../src/repository/user_repository.dart';
import '../../src/ui/pages/camera_page.dart';
import '../../src/ui/pages/edit_user_detail.dart';
import '../../src/ui/pages/search_page.dart';
import '../../src/ui/screens/article_detail.dart';
import '../../src/ui/screens/checkout_page.dart';
import '../../src/ui/screens/intro_page.dart';
import '../../src/ui/screens/momo_number.dart';
// import '../../src/ui/screens/login_page.dart';
import '../../src/ui/screens/otp_page_news.dart';
import '../../src/ui/screens/phone_login.dart';
import '../../src/ui/screens/radio_screen.dart';
import '../../src/ui/screens/report_news.dart';
import '../../src/ui/screens/take_video.dart';
import '../../src/ui/screens/trending_screen.dart';
import '../../src/ui/screens/tv_screen.dart';
import '../../src/ui/screens/live_videos.dart';
import '../../src/ui/screens/aboutus.dart';
import '../../src/ui/auth/signup_page.dart';
import '../../src/ui/screens/waiting_page.dart';
import '../../src/ui/tabbar.dart';

import '../ui/screens/video_detail.dart';

class RouteGenerator {
  static final userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (_) => TabScreen(
                  tabIndex: (args != null) ? args : 0,
                ));
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
        return MaterialPageRoute(
            builder: (_) => VideoDetailScreen(video: args));
      case '/articledetail':
        return MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(postId: args));
      case '/sendvideo':
        return MaterialPageRoute(builder: (_) => SendVideo());
      case '/searchpage':
        return MaterialPageRoute(builder: (_) => SearchPage());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => IntroPage());
      case '/otpPage':
        return MaterialPageRoute(
            builder: (_) => OtpPagenew(mobileNumber: args));
      case '/cart':
        return MaterialPageRoute(builder: (_) => CheckoutOnePage());
      case '/editProfile':
        return MaterialPageRoute(builder: (_) => EditUser());
      case '/momowaiting':
        return MaterialPageRoute(builder: (_) => MomoWaiting(data: args));
      case '/momonumber':
        return MaterialPageRoute(builder: (_) => MomoNumber(plan: args));
      case '/live':
        return MaterialPageRoute(builder: (_) => LiveScreen());
      case '/aboutus':
        return MaterialPageRoute(builder: (_) => Aboutus());
      case '/camera':
        return MaterialPageRoute(builder: (_) => CameraScreen());
      case '/gallery':
        return MaterialPageRoute(builder: (_) => Gallery());
      default:
        return MaterialPageRoute(builder: (_) => TabScreen());
    }
  }
}
