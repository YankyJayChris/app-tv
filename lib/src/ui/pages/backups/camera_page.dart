// import 'dart:io';
// import 'dart:typed_data';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:photo_manager/photo_manager.dart';
// import '../gallery.dart';
// import '../video_timer.dart';
// import 'package:path_provider/path_provider.dart';

// const Color barColor = const Color(0x20000000);

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({Key key}) : super(key: key);

//   @override
//   CameraScreenState createState() => CameraScreenState();
// }

// class CameraScreenState extends State<CameraScreen>
//     with AutomaticKeepAliveClientMixin {
//   CameraController _controller;
//   List<CameraDescription> _cameras;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool _isRecordingMode = false;
//   bool _isRecording = false;
//   var _latestImage;
//   final _timerKey = GlobalKey<VideoTimerState>();

//   @override
//   void initState() {
//     _initCamera();
//     getLastImage();
//     super.initState();
//   }

//   Future<void> _initCamera() async {
//     _cameras = await availableCameras();
//     _controller = CameraController(_cameras[0], ResolutionPreset.high);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     if (_controller != null) {
//       if (!_controller.value.isInitialized) {
//         return Container();
//       }
//     } else {
//       return const Center(
//         child: SizedBox(
//           width: 32,
//           height: 32,
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     if (!_controller.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       key: _scaffoldKey,
//       extendBody: true,
//       body: Stack(
//         children: <Widget>[
//           _buildCameraPreview(),
//           Positioned(
//             top: 24.0,
//             right: 12.0,
//             child: Column(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.switch_camera,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     _onCameraSwitch();
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.flash_on,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     _onCameraSwitch();
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 24.0,
//             left: 12.0,
//             child: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           if (_isRecordingMode)
//             Positioned(
//               left: 0,
//               right: 0,
//               top: 32.0,
//               child: VideoTimer(
//                 key: _timerKey,
//               ),
//             )
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }

//   Widget _buildCameraPreview() {
//     final size = MediaQuery.of(context).size;
//     return ClipRect(
//       child: Container(
//         child: Transform.scale(
//           scale: _controller.value.aspectRatio / size.aspectRatio,
//           child: Center(
//             child: AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: CameraPreview(_controller),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavigationBar() {
//     return Container(
//       color: barColor,
//       height: 100.0,
//       width: double.infinity,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Gallery(),
//                 ),
//               );
//             },
//             child: Container(
//               width: 40.0,
//               height: 40.0,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(4.0),
//                   child: AssetThumbnail(asset: _latestImage)),
//             ),
//           ),
//           CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 28.0,
//             child: IconButton(
//               icon: Icon(
//                 (_isRecordingMode)
//                     ? (_isRecording)
//                         ? Icons.stop
//                         : Icons.videocam
//                     : Icons.camera_alt,
//                 size: 28.0,
//                 color: (_isRecording) ? Colors.red : Colors.black,
//               ),
//               onPressed: () {
//                 if (!_isRecordingMode) {
//                   _captureImage();
//                 } else {
//                   if (_isRecording) {
//                     stopVideoRecording();
//                   } else {
//                     startVideoRecording();
//                   }
//                 }
//               },
//             ),
//           ),
//           IconButton(
//             icon: Icon(
//               (_isRecordingMode) ? Icons.camera_alt : Icons.videocam,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isRecordingMode = !_isRecordingMode;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> getLastImage() async {
//     // Set onlyAll to true, to fetch only the 'Recent' album
//     // which contains all the photos/videos in the storage
//     final albums = await PhotoManager.getAssetPathList(onlyAll: true);
//     final recentAlbum = albums.first;

//     // Now that we got the album, fetch all the assets it contains
//     final recentAssets = await recentAlbum.getAssetListRange(
//       start: 0, // start at index 0
//       end: 1, // end at a very big index (to get all the assets)
//     );

//     setState(() {
//       _latestImage = recentAssets[0];
//     });
//   }

//   Future<void> _onCameraSwitch() async {
//     final CameraDescription cameraDescription =
//         (_controller.description == _cameras[0]) ? _cameras[1] : _cameras[0];
//     if (_controller != null) {
//       await _controller.dispose();
//     }
//     _controller =
//         CameraController(cameraDescription, ResolutionPreset.high);
//     _controller.addListener(() {
//       if (mounted) setState(() {});
//       if (_controller.value.hasError) {
//         showInSnackBar('Camera error ${_controller.value.errorDescription}');
//       }
//     });

//     try {
//       await _controller.initialize();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   void _captureImage() async {
//     print('_captureImage');
//     if (_controller.value.isInitialized) {
//       SystemSound.play(SystemSoundType.click);
//       final Directory extDir = await getApplicationDocumentsDirectory();
//       final String dirPath = '${extDir.path}/tv1prime/images';
//       await Directory(dirPath).create(recursive: true);
//       final String filePath = '$dirPath/${_timestamp()}.jpeg';
//       print('path: $filePath');
//       await _controller.takePicture(filePath);
//       getLastImage();
//       setState(() {});
//     }
//   }

//   Future<String> startVideoRecording() async {
//     print('startVideoRecording');
//     if (!_controller.value.isInitialized) {
//       return null;
//     }
//     setState(() {
//       _isRecording = true;
//     });
//     _timerKey.currentState.startTimer();

//     final Directory extDir = await getApplicationDocumentsDirectory();
//     final String dirPath = '${extDir.path}/tv1prime/videos';
//     await Directory(dirPath).create(recursive: true);
//     final String filePath = '$dirPath/${_timestamp()}.mp4';

//     if (_controller.value.isRecordingVideo) {
//       // A recording is already started, do nothing.
//       return null;
//     }

//     try {
// //      videoPath = filePath;
//       await _controller.startVideoRecording(filePath);
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//     return filePath;
//   }

//   Future<void> stopVideoRecording() async {
//     if (!_controller.value.isRecordingVideo) {
//       return null;
//     }
//     _timerKey.currentState.stopTimer();
//     setState(() {
//       _isRecording = false;
//     });

//     try {
//       await _controller.stopVideoRecording();
//       getLastImage();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//       return null;
//     }
//   }

//   String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

//   void _showCameraException(CameraException e) {
//     logError(e.code, e.description);
//     showInSnackBar('Error: ${e.code}\n${e.description}');
//   }

//   void showInSnackBar(String message) {
//     _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
//   }

//   void logError(String code, String message) =>
//       print('Error: $code\nError Message: $message');

//   @override
//   bool get wantKeepAlive => true;
// }

// class AssetThumbnail extends StatelessWidget {
//   const AssetThumbnail({
//     Key key,
//     @required this.asset,
//   }) : super(key: key);

//   final AssetEntity asset;

//   @override
//   Widget build(BuildContext context) {
//     // We're using a FutureBuilder since thumbData is a future
//     return FutureBuilder<Uint8List>(
//       future: asset.thumbData,
//       builder: (_, snapshot) {
//         final bytes = snapshot.data;
//         // If we have no data, display a spinner
//         if (bytes == null) return CircularProgressIndicator();
//         // If there's data, display it as an image
//         return Image.memory(bytes, fit: BoxFit.cover);
//       },
//     );
//   }
// }
