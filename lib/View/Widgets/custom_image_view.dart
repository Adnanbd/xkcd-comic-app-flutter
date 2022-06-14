import 'package:flutter/material.dart';

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
    return Container(
      child: Container(
        //height: heightMain * .5,
        width: double.infinity,
        
      ),
    );
  }
}
