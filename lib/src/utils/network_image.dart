import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width, height;
  const PNetworkImage(this.image, {Key key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
            colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
          ),
        ),
      ),
    );
  }
}
