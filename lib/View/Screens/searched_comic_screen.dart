import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_card_comic_expandable.dart';

class SearchedComicScreen extends StatelessWidget {
  const SearchedComicScreen({
    Key? key,
    required this.searchedComic,
    required this.savedComic,
  }) : super(key: key);

  final List<AllComic> searchedComic;
  final List<AllComic> savedComic;

  @override
  Widget build(BuildContext context) {
    return searchedComic.isEmpty
    // If no query match with available comics
        ? Center(
            child: Text(
              "Sorry! No Comics Found!",
              style: GoogleFonts.barlow(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        : 
        //Showing a list of searched comics
        Container(
            alignment: Alignment.center,
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return CustomCardComicExpandable(
                  allComic: searchedComic[index],
                  savedComic: savedComic,
                );
              }),
              itemCount: searchedComic.length,
            ),
          );
  }
}
