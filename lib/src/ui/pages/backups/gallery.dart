// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';

// class Gallery extends StatefulWidget {
//   @override
//   _GalleryState createState() => _GalleryState();
// }

// class _GalleryState extends State<Gallery> {
//   // This will hold all the assets we fetched
//   List<AssetEntity> assets = [];

//   @override
//   void initState() {
//     _fetchAssets();
//     super.initState();
//   }

//   _fetchAssets() async {
//     // Set onlyAll to true, to fetch only the 'Recent' album
//     // which contains all the photos/videos in the storage
//     final albums = await PhotoManager.getAssetPathList(onlyAll: true);
//     final recentAlbum = albums.first;

//     // Now that we got the album, fetch all the assets it contains
//     final recentAssets = await recentAlbum.getAssetListRange(
//       start: 0, // start at index 0
//       end: 1000000, // end at a very big index (to get all the assets)
//     );

//     // Update the state and notify UI
//     setState(() => assets = recentAssets);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gallery'),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           // A grid view with 3 items per row
//           crossAxisCount: 3,
//         ),
//         itemCount: assets.length,
//         itemBuilder: (_, index) {
//           return AssetThumbnail(asset: assets[index]);
//         },
//       ),
//     );
//   }
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
//         return InkWell(
//           onTap: () {
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (_) {
//             //       if (asset.type == AssetType.image) {
//             //         // If this is an image, navigate to ImageScreen
//             //         return ImageScreen(imageFile: asset.file);
//             //       } else {
//             //         // if it's not, navigate to VideoScreen
//             //         return VideoScreen(videoFile: asset.file);
//             //       }
//             //     },
//             //   ),
//             // );
//           },
//           child: Stack(
//             children: [
//               // Wrap the image in a Positioned.fill to fill the space
//               Positioned.fill(
//                 child: Image.memory(bytes, fit: BoxFit.cover),
//               ),
//               // Display a Play icon if the asset is a video
//               if (asset.type == AssetType.video)
//                 Center(
//                   child: Container(
//                     color: Colors.purple[600],
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
