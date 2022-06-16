import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:xkcd/Controller/Providers/saved_comic_provider.dart';
import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/View/Screens/explanation_sceen.dart';
import 'package:xkcd/View/Widgets/custom_image_view.dart';
import 'package:xkcd/View/Widgets/custom_round_button.dart';

class CustomComicCardBody extends StatefulWidget {
  final AllComic allComic;
  final bool isFav;
  const CustomComicCardBody({
    Key? key,
    required this.allComic,
    required this.isFav,
  }) : super(key: key);

  @override
  State<CustomComicCardBody> createState() => _CustomComicCardBodyState();
}

class _CustomComicCardBodyState extends State<CustomComicCardBody> {
  bool isExpanded = false;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFav = widget.isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightMain = MediaQuery.of(context).size.height;
    double widthMain = MediaQuery.of(context).size.width;
    return Column(children: [
      Container(
        padding: const EdgeInsets.only(bottom: 10),
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
          ?
          //If there is no transcript available,
          // Then emply container will be displayed
          Container()
          : Container(
              padding: const EdgeInsets.only(bottom: 10),
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
                      //This button will expand container to
                      //display the content in transcript
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
                  const SizedBox(
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
      //Showing the comic image
      Container(
        width: widthMain * .8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: ImageView(
            comicImg: widget.allComic.imgs[0].sourceUrl,
            heightMain: heightMain),
      ),
      //Showing three buttons: 1) Explanation 2) Save/Unsave 3) Share
      Container(
        margin: EdgeInsets.only(top: heightMain * .03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //1) Explanation Button
            CustomRoundButton(
              icon: Icons.info,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExplanationScreen(
                      url: widget.allComic.explainUrl,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 12,
            ),
            //2) Save/Unsave Button
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
                    toast('Removed', duration: const Duration(seconds: 1));
                    if (kDebugMode) {
                      print("Removed From Saved Comics");
                    }
                  } else {
                    context
                        .read<SavedComicProvider>()
                        .addSavedComics(widget.allComic);
                    setState(() {
                      isFav = !isFav;
                    });
                    toast('Saved', duration: const Duration(seconds: 1));
                    if (kDebugMode) {
                      print("Added to Saved Comics");
                    }
                  }
                }),
            const SizedBox(
              width: 12,
            ),
            //3) Share Button
            CustomRoundButton(
              icon: Icons.share,
              onTap: () {
                Share.share(
                  'Hey! Check out this comic ${widget.allComic.sourceUrl}',
                );
              },
            ),
          ],
        ),
      ),
    ]);
  }
}
