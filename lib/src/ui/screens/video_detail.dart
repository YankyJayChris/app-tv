// import 'package:chewie/chewie.dart';
// import 'package:chewie/src/chewie_player.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/ui/widgets/header_section.dart';

import '../../models/video.dart';
import '../widgets/bottom_loder.dart';
import '../widgets/video_row_card.dart';

import 'package:screen/screen.dart';

class VideoDetailScreen extends StatefulWidget {
  final Video video;
  VideoDetailScreen({this.video});

  @override
  _VideoDetailScreenState createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  final FijkPlayer player = FijkPlayer();
  bool _isKeptOn = true;
  double _brightness = 1.0;
  static const FijkFit cover = FijkFit(
    sizeFactor: 1.0,
    aspectRatio: double.infinity,
    alignment: Alignment.center,
  );

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.video.videoLocation, autoPlay: true);

    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  refreshVideo() {
    player.setDataSource(widget.video.videoLocation, autoPlay: true);
  }
  
  initPlatformState() async {
    Screen.keepOn(_isKeptOn);
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState(() {
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                  child: Icon(
                    Icons.videocam,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/searchpage');
                    },
                    child: Icon(Icons.search, color: Colors.black)),
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
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * (30 / 100),
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: FijkView(
                  player: player,
                  fit: cover,
                  fsFit: cover,
                  height: MediaQuery.of(context).size.height * (30 / 100),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                width: MediaQuery.of(context).size.width * (95 / 100),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(widget.video.owner.avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * (75 / 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(widget.video.title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.start,
                                maxLines: 3),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(widget.video.owner.username,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.purple[800]),
                                    textAlign: TextAlign.start,
                                    maxLines: 3),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 5.0,
                                  width: 5.0,
                                  child: Container(
                                    width: 2,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: Colors.purple[800],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text("${widget.video.views} views",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                    textAlign: TextAlign.start,
                                    maxLines: 3),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                    HeaderSection(title: "Recently Videos", route: " "),
                    Container(
                      child: BlocBuilder<VideoBloc, VideoState>(
                          builder: (context, state) {
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
                          return Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: buildVideoListView(
                                state.latest, state.hasReachedMax),
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
            )
          ],
        ),
      ),
    );
  }

  ListView buildVideoListView(List<Video> videos, bool hasReachedMax) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= videos.length
            ? BottomLoader()
            : VideoWidgetRow(video: videos[index], pop: true,);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hasReachedMax ? videos.length : videos.length + 1,
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
          style: TextStyle(color: Colors.green[900]),
        ),
      ),
    );
  }
}
