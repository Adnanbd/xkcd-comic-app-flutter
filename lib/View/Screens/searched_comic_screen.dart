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
        ? Center(
            child: Text(
              "Sorry! No Comics Found!",
              style: GoogleFonts.barlow(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          )
        : Container(
            alignment: Alignment.center,
            //height: heightMain * .7,
            child: ListView.builder(
              //itemBuilder: _buildListItem,
              itemBuilder: ((p0, index) {
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
