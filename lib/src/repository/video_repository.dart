import 'package:newsapp/src/models/video_api_result.dart';
import 'package:newsapp/src/models/video.dart';
import "package:newsapp/src/resources/strings.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class VideoRepository {
  Future<List<Video>> getVideos(int latestOffset, int limit);
  Future<List<Video>> categoryVideos(int index, int startIndex, int limit);
}

class VideoRepositoryImpl implements VideoRepository {

  @override
  Future<List<Video>> getVideos(int latestOffset, int limit) async {
    var response = await http.get(AppStrings.primeURL + '?type=get_videos&limit=$limit&latest_offset=$latestOffset');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Video> videos = VideoApiResultModel.fromJson(data) as List<Video>;    
   
      return videos;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Video>> categoryVideos(int index, int startIndex, int limit) async {
    print("$index");
    var response = await http.get(AppStrings.newsUrl + 'read_by_category.php?category_id=$index&start=$startIndex&limit=$limit');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Video> videos = VideoApiResultModel.fromJson(data) as List<Video>;
      return videos;
    } else {
      throw Exception();
    }
  }

}