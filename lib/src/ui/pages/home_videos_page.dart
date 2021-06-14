import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/video/bloc.dart';
import '../../../src/blocs/video_categories/bloc.dart';
import '../../../src/models/video.dart';
import '../../../src/ui/widgets/bottom_loder.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/ui/widgets/video_card_col.dart';
import '../../../src/ui/widgets/video_row_card.dart';

class HomeBuilderVideoPage extends StatefulWidget {
  HomeBuilderVideoPage({Key key}) : super(key: key);

  @override
  _HomeBuilderVideoPageState createState() => _HomeBuilderVideoPageState();
}

class _HomeBuilderVideoPageState extends State<HomeBuilderVideoPage> {
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

  Future<Null> _refreshPage() async {
    BlocProvider.of<VideoBloc>(context).add(VideoRefresh());
    BlocProvider.of<VidCategoryBloc>(context).add(VidCategoriesRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
          if (state is VideoFailure) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Text('Pull down to refresh'),
              ),
            );
          }
          if (state is VideoSuccess) {
            if (state.latest.isEmpty) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text('no video found'),
                ),
              );
            }
          }
          if (state is VideoSuccess) {
            return Column(
              children: <Widget>[
                HeaderSection(title: "Latest Video", route: "news"),
                buildLatestVideo(state.latest),
                HeaderSection(title: "Recently Videos", route: " "),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: buildVideoListView(state.latest, state.hasReachedMax),
                ),
              ],
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
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

  Widget buildLatestVideo(List<Video> videos) {
    return Container(
      height: MediaQuery.of(context).size.height * (30 / 100),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length < 5 ? videos.length : 5,
        itemBuilder: (ctx, i) => VideoWidgetHor(video: videos[i]),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
