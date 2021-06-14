import 'package:equatable/equatable.dart';

import '../../../src/models/video.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoFailure extends VideoState {}

class VideoSuccess extends VideoState {
  final List<Video> featured;
  final List<Video> top;
  final List<Video> latest;
  final List<Video> fav;
  final bool hasReachedMax;

  const VideoSuccess({
    this.featured,
    this.top,
    this.latest,
    this.fav,
    this.hasReachedMax,
  });

  VideoSuccess copyWith({
    List<Video> featured,
    List<Video> top,
    List<Video> latest,
    List<Video> fav,
    bool hasReachedMax,
  }) {
    return VideoSuccess(
      featured: featured ?? this.featured,
      top: top ?? this.top,
      latest: latest ?? this.latest,
      fav: fav ?? this.fav,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [featured, top, latest, fav, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { videos: ${latest.length}, hasReachedMax: $hasReachedMax }';
}
