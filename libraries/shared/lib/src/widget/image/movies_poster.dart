import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  Poster(this.posterUrl, this.height);

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;
    return Material(
      borderRadius: BorderRadius.circular(Sizes.dp4(context)),
      elevation: 2.0,
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: posterUrl,
        placeholder: (context, url) => LoadingIndicator(),
        errorWidget: (context, url, error) => ErrorImage(),
      ),
    );
  }
}
