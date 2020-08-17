import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/src/blocs/article/bloc.dart';
import 'package:newsapp/src/blocs/video/bloc.dart';
import 'package:newsapp/src/models/article.dart';
import 'package:newsapp/src/ui/widgets/LatestVideo.dart';
import 'package:newsapp/src/ui/widgets/header_section.dart';
import 'package:newsapp/src/ui/widgets/recommended_news.dart';

var blueColor = Color(0xFF2a7efb);

enum PlayerState { stopped, playing, paused }

class RadioScreen extends StatefulWidget {
  RadioScreen({Key key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  Duration duration;
  Duration position;

  String url = "http://80.241.215.175:5000/";
  AudioPlayer audioPlayer;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;
  get isStop => playerState == PlayerState.stopped;

  bool isMuted = false;

  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    _audioPlayerStateSubscription.cancel();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();

    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
        play();
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
      });
    });
  }

  Future play() async {
    await audioPlayer.play(url);
    await audioPlayer.mute(false);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    _audioPlayerStateSubscription.cancel();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
    });
  }

  Future mute(bool muted) async {
    await audioPlayer.mute(muted);
    setState(() {
      isMuted = muted;
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                onTap: () {
                  Navigator.pushNamed(context, '/tv');
                },
                child: Icon(
                  Icons.live_tv,
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
          child: Column(
            children: <Widget>[
              Container(
                height: 300.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://radiotv1.rw/IMG/arton61.jpg?1568195784"),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.7),
                              Colors.white
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 30.0,
                                    child: Card(
                                      elevation: 5.0,
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0),
                                        height: 46.0,
                                        width: 46.0,
                                        child: Image.asset(
                                          'assets/images/radiologo.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: isPlaying ? () => pause() : null,
                                iconSize: 64.0,
                                icon: Icon(Icons.stop),
                                color: Colors.black,
                              ),
                              SizedBox(width: 32.0),
                              GestureDetector(
                                onTap: () {
                                  if (isStop || isPaused) {
                                    play();
                                  } else {
                                    pause();
                                  }
                                },
                                child: Card(
                                  elevation: 5.0,
                                  shape: CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 58.0,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(width: 32.0),
                              IconButton(
                                onPressed:
                                    isPlaying ? () => mute(!isMuted) : null,
                                iconSize: 64.0,
                                icon: Icon(
                                  isMuted ? Icons.volume_up : Icons.volume_off,
                                ),
                                color: Colors.black,
                              ),
                            ],
                          ),
                          Spacer(),
                          Text("91.1 FM",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32.0)),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Iyumvire radio one",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
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
                      })),
                  HeaderSection(title: "Latest Video", route: " "),
                  Container(
                    height: MediaQuery.of(context).size.height * (30 / 100),
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
                        return LatestVideoWidget(data: state.latest);
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                ],
              )
            ],
          ),
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
}
