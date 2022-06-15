import 'package:flutter/material.dart';
//import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:xkcd/Controller/Providers/saved_comic_provider.dart';
import 'package:xkcd/Controller/Services/shared_pref.dart';
import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Widgets/custom_image_view.dart';
import 'package:xkcd/View/Widgets/custom_round_button.dart';
import 'package:xkcd/View/screens/explaination_sceen.dart';

class CustomCardComic extends StatefulWidget {
  AllComic allComic;
  List<AllComic> savedComic;

  CustomCardComic({
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
    // TODO: implement initState
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
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: .5,
          )),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
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
                        "${widget.allComic.title}",
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
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerRight,
              child: Text(
                "${DateFormat.yMMMMd('en_US').format(widget.allComic.publishedAt)}",
                style: GoogleFonts.barlow(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.allComic.alt,
                style: GoogleFonts.barlow(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
            ),
            widget.allComic.transcript == ""
                ? Container()
                : Container(
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transcript : ",
                              style: GoogleFonts.barlow(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                icon: Icon(isExpanded
                                    ? Icons.arrow_circle_up_sharp
                                    : Icons.arrow_circle_down_sharp))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          isExpanded ? widget.allComic.transcript : "",
                          style: GoogleFonts.barlow(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
            Container(
              width: widthMain * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              child: ImageView(
                  comicImg: widget.allComic.imgs[0].sourceUrl,
                  heightMain: heightMain),
            ),
            Container(
              margin: EdgeInsets.only(top: heightMain * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomRoundButton(
                    icon: Icons.info,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExplainationScreen(
                            url: widget.allComic.explainUrl,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CustomRoundButton(
                      icon: Icons.bookmark,
                      color: isFav ? Colors.red : Colors.black,
                      onTap: () {
                        if (isFav) {
                          context
                              .read<SavedComicProvider>()
                              .removeSavedComics(widget.allComic.id);
                          setState(() {
                            isFav = !isFav;
                          });
                          toast('Removed', duration: Duration(seconds: 1));
                          print("Removed From Saved Comics");
                        } else {
                          context
                              .read<SavedComicProvider>()
                              .addSavedComics(widget.allComic);
                          setState(() {
                            isFav = !isFav;
                          });
                          toast('Saved', duration: Duration(seconds: 1));
                          print("Added to Saved Comics");
                        }
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  CustomRoundButton(
                    icon: Icons.share,
                    onTap: () {
                      Share.share(
                        'Hey! Check out this comic > ${widget.allComic.sourceUrl}',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
