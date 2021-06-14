import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

import 'src/blocs/article/article_bloc.dart';
import 'src/blocs/article/article_event.dart';
import 'src/blocs/auth/bloc.dart';
// import 'src/blocs/Payment/bloc.dart';
import 'src/blocs/categories/bloc.dart';
import 'src/blocs/video_categories/bloc.dart';
import 'src/blocs/video/bloc.dart';
import 'src/utils/routes.dart';

import 'src/blocs/payment/bloc.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ArticleBloc>(
          create: (context) =>
              ArticleBloc(httpClient: http.Client())..add(ArticleFetched()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) =>
              CategoryBloc(httpClient: http.Client())..add(CategoriesFetched()),
        ),
        BlocProvider<VidCategoryBloc>(
          create: (context) => VidCategoryBloc(httpClient: http.Client())
            ..add(VidCategoriesFetched()),
        ),
        BlocProvider<VideoBloc>(
          create: (context) =>
              VideoBloc(httpClient: http.Client())..add(VideoFetched()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(httpClient: http.Client())..add(AppStarted()),
        ),
        BlocProvider<PaymentsBloc>(
          create: (context) =>
              PaymentsBloc(httpClient: http.Client())..add(PaymentsStarted()),
        ),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'TV1 PRIME',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.purple[800],
            accentColor: Colors.purple[100],
            primarySwatch: Colors.purple,
            iconTheme: IconThemeData(color: Colors.purple[800]),
          ),
          initialRoute: "/home",
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
