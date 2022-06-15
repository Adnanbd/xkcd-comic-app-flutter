import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

import 'package:xkcd/View/Widgets/custom_progress.dart';

class ImageView extends StatelessWidget {
  double heightMain;
  String comicImg;
  ImageView({
    required this.comicImg,
    required this.heightMain,
  });

  @override
  Widget build(BuildContext context) {
    return FullScreenWidget(
      child: Container(
        //height: heightMain * .5,
        width: double.infinity,
        child: InteractiveViewer(
          panEnabled: false, // Set it to false to prevent panning.
          boundaryMargin: EdgeInsets.all(0),

          minScale: 0.1,
          maxScale: 4,
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: comicImg,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: customProgressWidget(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
