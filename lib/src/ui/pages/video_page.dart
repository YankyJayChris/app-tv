import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/models/video.dart';
import 'package:newsapp/src/ui/widgets/bottom_loder.dart';
import 'package:newsapp/src/ui/widgets/header_section.dart';
import 'package:newsapp/src/ui/widgets/video_card_col.dart';
import 'package:newsapp/src/ui/widgets/video_row_card.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/logo_44.png',
              width: 100,
              height: 200,
            ),
            SizedBox(
              width: 5.0,
            ),
            // Text(
            //   'TV1 PRIME',
            //   style: TextStyle(color: Colors.black, fontFamily: 'BebasNeue'),
            // ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sendvideo');
                },
                child: Icon(
                  Icons.videocam,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                  onTap: () {}, child: Icon(Icons.search, color: Colors.black)),
              SizedBox(width: 15),
              // GestureDetector(
              //   onTap: () {},
              //   child: Image.asset(
              //     'assets/icons/user.png',
              //     width: 40,
              //     height: 30,
              //   ),
              // )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return null;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
            if (state is VideoFailure) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text('failed to fetch Videos'),
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
                    child:
                        buildVideoListView(state.latest, state.hasReachedMax),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
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
      ),
    );
  }
}
