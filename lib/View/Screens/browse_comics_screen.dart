import 'package:flutter/material.dart';

import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_card_comic.dart';

class BrowseComicScreen extends StatefulWidget {
  List<AllComic> allComic;
  List<AllComic> savedComic;
  BrowseComicScreen({required this.allComic, required this.savedComic});

  @override
  State<BrowseComicScreen> createState() => _BrowseComicScreenState();
}

class _BrowseComicScreenState extends State<BrowseComicScreen> {

  

  @override
  Widget build(BuildContext context) {
    late ScrollController controller;
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        
        itemBuilder: ((p0, index) {
          return CustomCardComic(
                  allComic: widget.allComic[index],
                  savedComic: widget.savedComic,
                );
        }),
        itemCount: widget.allComic.length,
      ),
    );
  }

}
