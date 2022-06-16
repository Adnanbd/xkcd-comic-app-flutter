import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

import 'package:xkcd/View/Widgets/custom_progress.dart';

class ImageView extends StatelessWidget {
  final double heightMain;
  final String comicImg;
  
  const ImageView({super.key, 
    required this.comicImg,
    required this.heightMain,
  });

  @override
  Widget build(BuildContext context) {
    return 
    //Perform Click image to full screen with the help of FullScreenWidget 
    FullScreenWidget(
      child: SizedBox(
        width: double.infinity,
        //Pinch image to Zoom In/Out with the help of InteractiveViewer
        child: InteractiveViewer(
          panEnabled: false, // Set it to false to prevent panning.
          boundaryMargin: const EdgeInsets.all(0),

          minScale: 0.1,
          maxScale: 4,
          child: CachedNetworkImage( //CachedNetworkImage helps to preview image offline
            fit: BoxFit.contain,
            imageUrl: comicImg,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: customProgressWidget(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
