import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:newsapp/src/blocs/article/article_bloc.dart';
import 'package:newsapp/src/blocs/article/article_event.dart';
import 'package:newsapp/src/blocs/auth/bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/repository/local_data.dart';
import 'package:newsapp/src/utils/routes.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LocalData prefs = LocalData();
  bool seen = false;

  @override
  void initState() {
    _checkSeen();
    super.initState();
  }

  _checkSeen() {
    Future<bool> myseen = prefs.getWelcom();
    myseen.then((data) {
      if (data) {
        return "/home";
      } else {
        return "/onboarding";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (context) =>
              ArticleBloc(httpClient: http.Client())..add(ArticleFetched()),
        ),
        BlocProvider<VideoBloc>(
          create: (context) =>
              VideoBloc(httpClient: http.Client())..add(VideoFetched()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(httpClient: http.Client())..add(AppStarted()),
        ),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: 'TV1 PRIME',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.purple[800],
            accentColor: Colors.purple[100],
            primarySwatch: Colors.green,
            iconTheme: IconThemeData(color: Color(0xFF018100)),
          ),
          initialRoute: _checkSeen(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
