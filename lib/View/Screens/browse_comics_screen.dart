import 'package:flutter/material.dart';

import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_card_comic.dart';
import 'package:xkcd/View/Widgets/custom_progress.dart';

class BrowseComicScreen extends StatefulWidget {
  final List<AllComic> allComic;
  final List<AllComic> savedComic;
  const BrowseComicScreen({
    super.key,
    required this.allComic,
    required this.savedComic,
  });

  @override
  State<BrowseComicScreen> createState() => _BrowseComicScreenState();
}

class _BrowseComicScreenState extends State<BrowseComicScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.allComic.isEmpty
        ?
        //If there is no comic available
        Center(
            child: customProgressWidget(),
          )
        :
        //Showing All Comics
        Container(
            alignment: Alignment.center,
            child: ListView.builder(
              itemBuilder: ((context, index) {
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
