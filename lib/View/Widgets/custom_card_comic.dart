import 'package:flutter/material.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';

import 'package:xkcd/Controller/Services/shared_pref.dart';
import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_comic_card_body.dart';

class CustomCardComic extends StatefulWidget {
  final AllComic allComic;
  final List<AllComic> savedComic;

  const CustomCardComic({
    super.key, 
    required this.allComic,
    required this.savedComic,
  });

  @override
  State<CustomCardComic> createState() => _CustomCardComicState();
}

class _CustomCardComicState extends State<CustomCardComic> {
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

    //context.read<IndexProvider>().
  }

  @override
  Widget build(BuildContext context) {
    double heightMain = MediaQuery.of(context).size.height;
    double widthMain = MediaQuery.of(context).size.width;

    return Container(
      //height: heightMain * .7,
      width: widthMain * .9,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: .5,
          )),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              width: widthMain * .8,
              height: heightMain * 0.06,
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
                    width: widthMain * 0.6,
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
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.yMMMMd('en_US').format(widget.allComic.publishedAt),
                style: GoogleFonts.barlow(
                  fontSize: 16,
                ),
              ),
            ),
            CustomComicCardBody(allComic: widget.allComic, isFav: isFav),
          ],
        ),
      ),
    );
  }
}
