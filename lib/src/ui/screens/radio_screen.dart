import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:flutter_exoplayer/audio_notification.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../src/blocs/article/bloc.dart';
import '../../../src/blocs/video/bloc.dart';
import '../../../src/models/article.dart';
import '../../../src/ui/widgets/LatestVideo.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/ui/widgets/recommended_news.dart';

var blueColor = Color(0xFF2a7efb);

class RadioScreen extends StatefulWidget {
  RadioScreen({Key key}) : super(key: key);

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final String url = "http://80.241.215.175:5000/";

  AudioPlayer _audioPlayer;

  AudioNotification audioObject = AudioNotification(
    smallIconFileName: "ic_launcher",
    title: "Radio 1",
    subTitle: "Feel it, Live it, Love it",
    largeIconUrl: "assets/images/logo_44.png",
    isLocal: false,
    notificationDefaultActions: NotificationDefaultActions.ALL,
    notificationCustomActions: NotificationCustomActions.TWO,
  );

  PlayerState _playerState = PlayerState.RELEASED;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;
  StreamSubscription _playerAudioSessionIdSubscription;
  StreamSubscription _notificationActionCallbackSubscription;

  get _isPlaying => _playerState == PlayerState.PLAYING;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _playerAudioSessionIdSubscription?.cancel();
    _notificationActionCallbackSubscription?.cancel();
    super.dispose();
  }

  Future<Null> _refreshPage() async {
    _audioPlayer.dispose();
    _initAudioPlayer();
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
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/tv');
                },
                child: Icon(
                  Icons.live_tv,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/searchpage');
                },
                child: Icon(Icons.search, color: Colors.black),
              ),
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
        onRefresh: _refreshPage,
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
                              image: AssetImage('assets/images/radiologo.png'),
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
                                onPressed: _isPlaying ? () => _stop() : null,
                                iconSize: 64.0,
                                icon: Icon(Icons.stop),
                                color: Colors.black,
                              ),
                              SizedBox(width: 32.0),
                              GestureDetector(
                                onTap: _isPlaying
                                    ? () => _pause()
                                    : () => _resume(),
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
                                          _isPlaying
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
                                onPressed: _isPlaying ? () => _pause() : null,
                                iconSize: 64.0,
                                icon: Icon(
                                  _isPlaying
                                      ? Icons.volume_off
                                      : Icons.volume_up,
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

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _playerStateSubscription =
        _audioPlayer.onPlayerStateChanged.listen((playerState) {
      setState(() {
        _playerState = playerState;
        print(_playerState);
      });
    });
    _playerAudioSessionIdSubscription =
        _audioPlayer.onAudioSessionIdChange.listen((audioSessionId) {
      print("audio Session Id: $audioSessionId");
    });
    _notificationActionCallbackSubscription = _audioPlayer
        .onNotificationActionCallback
        .listen((notificationActionName) {
      //do something
    });
    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((a) {});
    _play();
  }

  Future<void> _play() async {
    if (url != null) {
      final Result result = await _audioPlayer.play(
        url,
        repeatMode: true,
        respectAudioFocus: false,
        playerMode: PlayerMode.BACKGROUND,
        audioNotification: audioObject,
      );
      if (result == Result.ERROR) {
        print("something went wrong in play method :(");
      }
    }
  }

  Future<void> _resume() async {
    final Result result = await _audioPlayer.resume();
    if (result == Result.FAIL) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.ERROR) {
      print("something went wrong in resume :(");
    }
  }

  Future<void> _pause() async {
    final Result result = await _audioPlayer.pause();
    if (result == Result.FAIL) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.ERROR) {
      print("something went wrong in pause :(");
    }
  }

  Future<void> _stop() async {
    final Result result = await _audioPlayer.stop();
    if (result == Result.FAIL) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.ERROR) {
      print("something went wrong in stop :(");
    }
  }

  Future<void> _release() async {
    final Result result = await _audioPlayer.release();
    if (result == Result.FAIL) {
      print(
          "you tried to call audio conrolling methods on released audio player :(");
    } else if (result == Result.ERROR) {
      print("something went wrong in release :(");
    }
  }
}
