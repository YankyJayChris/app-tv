import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/article/bloc.dart';
import '../../../src/models/article.dart';
import '../../../src/ui/widgets/bottom_loder.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/ui/widgets/recommended_news.dart';
import '../../../src/ui/widgets/vertical_items.dart';

class CategoryNewsPage extends StatefulWidget {
  CategoryNewsPage({Key key}) : super(key: key);

  @override
  _CategoryNewsPageState createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  final _scrollThreshold = 200.0;
  ArticleBloc _articleBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _articleBloc = BlocProvider.of<ArticleBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _articleBloc.add(ArticleFetched());
    }
  }

  Future<Null> _refreshPage() async {
    BlocProvider.of<ArticleBloc>(context).add(ArticleRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: SingleChildScrollView(
        controller: _scrollController,
        child:
            BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
          if (state is ArticleFailure) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Text('Pull down to refresh'),
              ),
            );
          }
          if (state is ArticleSuccess) {
            if (state.articles.isEmpty) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text('no Articles found'),
                ),
              );
            }
          }
          if (state is ArticleSuccess) {
            return Column(
              children: <Widget>[
                HeaderSection(title: "Recently News", route: " "),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child:
                      buildVideoListView(state.articles, state.hasReachedMax),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    print(message);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.purple[800]),
        ),
      ),
    );
  }

  ListView buildVideoListView(List<Article> articles, bool hasReachedMax) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= articles.length
            ? BottomLoader()
            : RowItem(post: articles[index]);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hasReachedMax ? articles.length : articles.length + 1,
    );
  }

  Widget buildLatestVideo(List<Article> articles) {
    return Container(
      height: MediaQuery.of(context).size.height * (30 / 100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length < 5 ? articles.length : 5,
        itemBuilder: (ctx, i) => RecommendedNews(post: articles[i]),
      ),
    );
  }
}
