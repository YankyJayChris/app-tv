// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// class TrimmerView extends StatefulWidget {
//   final File videoFile;
//   TrimmerView({
//     @required this.videoFile,
//   });
//   @override
//   _TrimmerViewState createState() => _TrimmerViewState();
// }

// class _TrimmerViewState extends State<TrimmerView> {
//   final Trimmer trimmer = Trimmer();
//   double _startValue = 0.0;
//   double _endValue = 0.0;
//   File video;

//   bool _isPlaying = false;
//   bool _progressVisibility = false;

//   @override
//   void initState() {
//     super.initState();
//     initialize();
//   }

//   void initialize() async {
//     await trimmer.loadVideo(videoFile: widget.videoFile);
//   }

//   Future<String> _saveVideo() async {
//     setState(() {
//       _progressVisibility = true;
//     });

//     String _value;

//     await trimmer
//         .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
//         .then((value) {
//       setState(() {
//         _progressVisibility = false;
//         _value = value;
//       });
//     });

//     return _value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Trimmer"),
//       ),
//       body: Builder(
//         builder: (context) => Center(
//           child: Container(
//             padding: EdgeInsets.only(bottom: 30.0),
//             color: Colors.black,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Visibility(
//                   visible: _progressVisibility,
//                   child: LinearProgressIndicator(
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 RaisedButton(
//                   onPressed: _progressVisibility
//                       ? null
//                       : () async {
//                           _saveVideo().then((outputPath) {
//                             print('OUTPUT PATH: $outputPath');
//                             final snackBar = SnackBar(
//                                 content: Text('Video Saved successfully'));
//                             Scaffold.of(context).showSnackBar(snackBar);
//                           });
//                         },
//                   child: Text("SAVE"),
//                 ),
//                 Expanded(
//                   child: VideoViewer(),
//                 ),
//                 Center(
//                   child: TrimEditor(
//                     viewerHeight: 50.0,
//                     viewerWidth: MediaQuery.of(context).size.width,
//                     onChangeStart: (value) {
//                       _startValue = value;
//                     },
//                     onChangeEnd: (value) {
//                       _endValue = value;
//                     },
//                     onChangePlaybackState: (value) {
//                       setState(() {
//                         _isPlaying = value;
//                       });
//                     },
//                   ),
//                 ),
//                 FlatButton(
//                   child: _isPlaying
//                       ? Icon(
//                           Icons.pause,
//                           size: 80.0,
//                           color: Colors.white,
//                         )
//                       : Icon(
//                           Icons.play_arrow,
//                           size: 80.0,
//                           color: Colors.white,
//                         ),
//                   onPressed: () async {
//                     bool playbackState = await trimmer.videPlaybackControl(
//                       startValue: _startValue,
//                       endValue: _endValue,
//                     );
//                     setState(() {
//                       _isPlaying = playbackState;
//                     });
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
