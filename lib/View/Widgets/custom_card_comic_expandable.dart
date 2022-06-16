import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

import 'package:xkcd/Controller/Services/shared_pref.dart';
import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_comic_card_body.dart';

class CustomCardComicExpandable extends StatefulWidget {
  final AllComic allComic;
  final List<AllComic> savedComic;

  const CustomCardComicExpandable({
    super.key, 
    required this.allComic,
    required this.savedComic,
  });

  @override
  State<CustomCardComicExpandable> createState() => _CustomCardComicExpandableState();
}

class _CustomCardComicExpandableState extends State<CustomCardComicExpandable> {
  SharedPref sharedPref = SharedPref();
  bool isFav = false;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isFav =
          widget.savedComic.any((element) => element.id == widget.allComic.id);
    });

  }

  @override
  Widget build(BuildContext context) {
    double heightMain = MediaQuery.of(context).size.height;
    double widthMain = MediaQuery.of(context).size.width;

    return Container(
      width: widthMain * .9,
      margin:  const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: .5,
          )),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(20),
        title: SizedBox(
          width: widthMain * .7,
          height: heightMain * 0.08,
          //Contents in "child" will be appreared either collapsed or expanded
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Badge(
                toAnimate: false,
                shape: BadgeShape.square,
                badgeColor: Colors.black,
                borderRadius: BorderRadius.circular(8),
                badgeContent: Text(
                  '#${widget.allComic.id}',
                  style: GoogleFonts.barlow(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: widthMain * .5,
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    widget.allComic.title,
                    style: GoogleFonts.barlow(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        subtitle: Container(
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.centerRight,
          child: Text(
            DateFormat.yMMMMd('en_US').format(widget.allComic.publishedAt),
            style: GoogleFonts.barlow(
              fontSize: 16,
            ),
          ),
        ),
        //Contents in "children" will apprear when the tile is expanded
        children: [
          CustomComicCardBody(allComic: widget.allComic, isFav: isFav),
        ],
      ),
    );
  }
}
