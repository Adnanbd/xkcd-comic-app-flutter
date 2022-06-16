import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_card_comic_expandable.dart';

class SavedComicScreen extends StatefulWidget {
  const SavedComicScreen({
    Key? key,
    required this.savedComic,
  }) : super(key: key);

  final List<AllComic> savedComic;

  @override
  State<SavedComicScreen> createState() => _SavedComicScreenState();
}

class _SavedComicScreenState extends State<SavedComicScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:
          //When initially no saved comic
          widget.savedComic.isEmpty
              ? Text(
                  "No Saved Comics",
                  style: GoogleFonts.barlow(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              :
              //Showing a list of saved comics
              ListView.builder(
                  itemBuilder: ((context, index) {
                    return CustomCardComicExpandable(
                      allComic: widget.savedComic[index],
                      savedComic: widget.savedComic,
                    );
                  }),
                  itemCount: widget.savedComic.length,
                ),
    );
  }
}
