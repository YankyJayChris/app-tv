import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/article/bloc.dart';
import '../../../src/blocs/video/bloc.dart';
import '../../../src/models/article.dart';
import '../../../src/models/video.dart';
import '../../../src/ui/widgets/LatestVideo.dart';
import '../../../src/ui/widgets/bottom_loder.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/ui/widgets/recommended_news.dart';
import '../../../src/ui/widgets/video_row_card.dart';

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final _scrollController = ScrollController(initialScrollOffset: 0.0);
  final _scrollThreshold = 200.0;
  VideoBloc _videoBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _videoBloc = BlocProvider.of<VideoBloc>(context);
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
      _videoBloc.add(VideoFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending News"),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            HeaderSection(title: "Latest News", route: "news"),
            Container(
              height: MediaQuery.of(context).size.height * (30 / 100),
              child: BlocBuilder<ArticleBloc, ArticleState>(
                  builder: (context, state) {
                if (state is ArticleFailure) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: Text('failed to fetch Videos'),
                    ),
                  );
                }
                if (state is ArticleSuccess) {
                  if (state.articles.isEmpty) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: Text('no video found'),
                      ),
                    );
                  }
                }
                if (state is ArticleSuccess) {
                  return buildLatestVideo(state.articles);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            HeaderSection(title: "Top Videos", route: " "),
            Container(
              child:
                  BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
                if (state is VideoFailure) {
                  return Center(
                    child: Text('failed to fetch Videos'),
                  );
                }
                if (state is VideoSuccess) {
                  if (state.latest.isEmpty) {
                    return Center(
                      child: Text('no video found'),
                    );
                  }
                }
                if (state is VideoSuccess) {
                  return LatestVideoWidget(data: state.top);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
            HeaderSection(title: "Recently Videos", route: " "),
            Container(
              child:
                  BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
                if (state is VideoFailure) {
                  return Center(
                    child: Text('failed to fetch Videos'),
                  );
                }
                if (state is VideoSuccess) {
                  if (state.latest.isEmpty) {
                    return Center(
                      child: Text('no article found'),
                    );
                  }
                }
                if (state is VideoSuccess) {
                  return Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child:
                        buildVideoListView(state.latest, state.hasReachedMax),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
            ),
          ],
        ),
      ),
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

  ListView buildVideoListView(List<Video> videos, bool hasReachedMax) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= videos.length
            ? BottomLoader()
            : VideoWidgetRow(video: videos[index]);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hasReachedMax ? videos.length : videos.length + 1,
    );
  }
}
