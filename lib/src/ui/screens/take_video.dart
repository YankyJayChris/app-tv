import 'package:flutter/material.dart';

class SendVideo extends StatefulWidget {
  @override
  _SendVideoState createState() => _SendVideoState();
}

class _SendVideoState extends State<SendVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Video"),
      ),
      body: Container(
        child: Center(
          child: Text("Coming soon"),
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../src/ui/widgets/video_trimer.dart';
// import 'package:video_trimmer/video_trimmer.dart';

// class SendVideo extends StatefulWidget {
//   @override
//   _SendVideoState createState() => _SendVideoState();
// }

// class _SendVideoState extends State<SendVideo> {
//   final Trimmer _trimmer = Trimmer();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Trimmer"),
//       ),
//       body: Center(
//         child: Container(
//           child: RaisedButton(
//             child: Text("LOAD VIDEO"),
//             onPressed: () async {
//               File file = await ImagePicker.pickVideo(
//                 source: ImageSource.gallery,
//               );
//               if (file != null) {
//                 await _trimmer.loadVideo(videoFile: file);
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) {
//                   return TrimmerView(_trimmer);
//                 }));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
