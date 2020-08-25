import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;


import 'package:newsapp/src/blocs/article/article_bloc.dart';
import 'package:newsapp/src/blocs/article/article_event.dart';
import 'package:newsapp/src/blocs/auth/bloc.dart';
import 'package:newsapp/src/blocs/login/bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/repository/user_preferences.dart';
import 'package:newsapp/src/utils/routes.dart';
import 'package:newsapp/src/repository/user_repository.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final bool onboarding = UserPreferences().onBoarding;
  static final userRepository =
      UserRepository(firebaseAuth: FirebaseAuth.instance);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(httpClient: http.Client())..add(ArticleFetched()),
        ),
        BlocProvider<VideoBloc>(
          create: (context) => VideoBloc(httpClient: http.Client())..add(VideoFetched()),),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(httpClient: http.Client())..add(AppStarted()),),
      ],
      child: MaterialApp(
        title: 'TV1 PRIME',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple[800],
          accentColor: Colors.purple[100],
          primarySwatch: Colors.green,
          iconTheme: IconThemeData(color: Color(0xFF018100)),
        ),
        initialRoute: '/home',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
