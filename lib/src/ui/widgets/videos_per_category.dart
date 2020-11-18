import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:newsapp/src/models/video.dart';
import 'package:newsapp/src/models/video_cat.dart';
import 'package:newsapp/src/resources/strings.dart';
import 'package:newsapp/src/ui/widgets/bottom_loder.dart';
import 'package:newsapp/src/ui/widgets/video_card_col.dart';
import 'package:newsapp/src/ui/widgets/video_row_card.dart';

class VideoCatBuilder extends StatelessWidget {
  final String catId;

  VideoCatBuilder({this.catId});

  @override
  Widget build(BuildContext context) {
    return _catPostsData(catId);
  }

  Future<List<Video>> _getCatPosts(String text) async {
    var response = await http.get(
        AppStrings.primeURL + '?type=get_videos_by_category&category_id=$text');
    // print(json.decode(response.body));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Video> videos = VideosCat.fromJson(data).videos;
      print(data);
      return videos;
    } else {
      throw Exception('error fetching articles');
    }
  }

  FutureBuilder _catPostsData(String catId) {
    return FutureBuilder<List<Video>>(
      future: _getCatPosts(catId),
      builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
        List<Video> data = snapshot.data;
        if (data == null) {
          return Center(child: CircularProgressIndicator());
        } else if (data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * (95 / 100),
                  height: MediaQuery.of(context).size.height * (25 / 100),

                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/images/emptyState.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("This category has no news yet"),
              ],
            ),
          );
        } else if (data != null) {
          List<Video> data = snapshot.data;
          print("am here in video cat builder");
          return buildVideoListView(data);
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView buildVideoListView(
    List<Video> videos,
  ) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return VideoWidgetRow(
          video: videos[index],
          pop: true,
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: videos.length,
    );
  }
}
