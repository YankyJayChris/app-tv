// import 'package:chewie/chewie.dart';
// import 'package:chewie/src/chewie_player.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../src/models/live.dart';
import '../../../src/models/live_links.dart';
import '../../../src/ui/widgets/Live_row_card.dart';
import '../../../src/ui/widgets/header_section.dart';
import '../../../src/resources/strings.dart';

import 'package:screen/screen.dart';

class LiveScreen extends StatefulWidget {
  LiveScreen({Key key}) : super(key: key);

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final FijkPlayer player = FijkPlayer();
  bool _isKeptOn = true;
  String videoLink;
  String liveUrl = "rtmp://80.241.215.175:1935/tv1rwanda/tv1rwanda";
  String liveTitle = "TV1 LIVE";
  String liveImage = "TV1 LIVE";

  static const FijkFit cover = FijkFit(
    sizeFactor: 1.0,
    aspectRatio: double.infinity,
    alignment: Alignment.center,
  );

  @override
  void initState() {
    super.initState();
    player.setDataSource(liveUrl, autoPlay: true);

    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  initPlatformState() async {
    Screen.keepOn(_isKeptOn);
    bool keptOn = await Screen.isKeptOn;
    setState(() {
      _isKeptOn = keptOn;
    });
  }

  Future<Null> _refreshPage() async {
    await player.setDataSource(liveUrl, autoPlay: true);
    print(liveUrl);
    initPlatformState();
  }

  Future<List<Live>> _getLiveLinks() async {
    var response = await http.get(AppStrings.primeURL + '?type=fetch_lives');
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Live> videos = Live_data.fromJson(data).data;
      print(videos);
      return videos;
    } else {
      throw Exception('error fetching Live Links');
    }
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
                  onTap: () async{
                    await player.reset();
                    setState(() {
                      liveUrl =
                          "rtmp://80.241.215.175:1935/tv1rwanda/tv1rwanda";
                      liveTitle = "TV1 LIVE";
                      liveImage = "TV1 LIVE";
                    });
                    _refreshPage();
                  },
                  child: Icon(
                    Icons.live_tv,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    player.release();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/radio');
                  },
                  child: Icon(
                    Icons.radio,
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
        body: RefreshIndicator(
          onRefresh: _refreshPage,
          child: Column(
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
              Container(
                width: MediaQuery.of(context).size.width * (95 / 100),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.purple, width: 2),
                        image: DecorationImage(
                          image: (liveImage == "TV1 LIVE")
                              ? AssetImage('assets/images/logo_44.png')
                              : NetworkImage(liveImage),
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
                            child: Text(liveTitle,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      HeaderSection(title: "Latest Live", route: "news"),
                      Container(
                        child: FutureBuilder(
                          future: _getLiveLinks(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              print(snapshot.data);
                              return buildLatestLive(snapshot.data);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLatestLive(List<Live> lives) {
    return ListView.builder(
      itemCount: lives.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, i) => LiveWidgetRow(
          live: lives[i],
          onTap: () async{
            await player.reset();
            await player.setDataSource(lives[i].url, autoPlay: true);
            setState(() {
              liveUrl = lives[i].url;
              liveTitle = lives[i].title;
              liveImage = lives[i].image;
            });
            print(lives[i].url);
          }),
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
