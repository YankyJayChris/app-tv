import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../src/blocs/video/bloc.dart';
import '../../../src/blocs/video/video_event.dart';
import '../../../src/models/video.dart';
import '../../../src/models/all_video_result.dart';
import '../../../src/resources/strings.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final http.Client httpClient;

  VideoBloc({@required this.httpClient}) : super(VideoInitial());

  @override
  Stream<Transition<VideoEvent, VideoState>> transformEvents(
    Stream<VideoEvent> events,
    TransitionFunction<VideoEvent, VideoState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<VideoState> mapEventToState(VideoEvent event) async* {
    final currentState = state;
    if (event is VideoFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is VideoInitial) {
          final List videos = await _fetchVideos(0, 5);
          yield VideoSuccess(
            featured: videos[0],
            top: videos[1],
            latest: videos[2],
            fav: videos[3],
            hasReachedMax: false,
          );
          return;
        }
        if (currentState is VideoSuccess) {
          Video latestvideo =
              currentState.latest[currentState.latest.length - 1];
          final List videos = await _fetchVideos(latestvideo.id, 5);
          print(videos[2].isEmpty);
          yield videos[2].isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : VideoSuccess(
                  featured: videos[0],
                  top: videos[1],
                  latest: currentState.latest + videos[2],
                  fav: videos[3],
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield VideoFailure();
      }
    }

    if (event is VideoRefresh) {
      final List videos = await _fetchVideos(0, 5);
      yield VideoSuccess(
        featured: videos[0],
        top: videos[1],
        latest: videos[2],
        fav: videos[3],
        hasReachedMax: false,
      );
      return;
    }
  }

  bool _hasReachedMax(VideoState state) =>
      state is VideoSuccess && state.hasReachedMax;

  Future<List> _fetchVideos(int startIndex, int limit) async {
    final response = await httpClient.get(AppStrings.primeURL +
        '?type=get_videos&limit=$limit&latest_offset=$startIndex');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final allVideos = VideoApi.fromJson(data).data;
      List<Video> top = allVideos.top;
      List<Video> featured = allVideos.featured;
      List<Video> latest = allVideos.latest;
      List<Video> fav = allVideos.fav;
      return [featured, top, latest, fav];
    } else {
      throw Exception('error fetching videos');
    }
  }
}
