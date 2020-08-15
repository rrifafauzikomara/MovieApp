import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ArcBannerImage extends StatelessWidget {
  ArcBannerImage(this.imageUrl);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: ArcClipper(),
        child: Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => LoadingIndicator(),
            errorWidget: (context, url, error) => ErrorImage(),
          ),
        ));
  }
}
