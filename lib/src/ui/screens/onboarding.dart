import 'package:flutter/material.dart';
import 'package:newsapp/src/repository/user_preferences.dart';
import 'package:sk_onboarding_screen/flutter_onboarding.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';


class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnboardingState();
  }
}

class OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  String data;

  @override
  void initState() {
    data = UserPreferences().userData;

    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _globalKey,
      body: SKOnboardingScreen(
        bgColor: Colors.white,
        themeColor: Colors.purple[800],
        pages: pages,
        skipClicked: (value) {
          print(value);
          UserPreferences().onBoarding = true;
          Navigator.pushNamed(context, '/home');
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Welcom to tv1 prime"),
          ));
        },
        getStartedClicked: (value) {
          print(value);
          UserPreferences().onBoarding = true;
          Navigator.pushNamed(context, '/home');
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Get Started clicked"),
          ));
        },
      ),
    );
  }

  final pages = [
    SkOnboardingModel(
        title: 'Our Objectives',
        description:
            'To widen the scope of information and knowledge of the local people.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/onboarding1.png'),
    SkOnboardingModel(
        title: 'A VOICE OF THE VOICELESS',
        description:
            'Our information and documentaries cover the real concerns of the population and this in all areas.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/onboarding2.png'),
    SkOnboardingModel(
        title: 'Pay quick and easy',
        description: 'Pay for order using credit or debit card',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/onboarding3.png'),
  ];
}