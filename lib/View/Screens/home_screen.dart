import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'package:xkcd/Controller/Providers/all_comic_provider.dart';
import 'package:xkcd/Controller/Providers/saved_comic_provider.dart';
import 'package:xkcd/View/Widgets/custom_card_comic.dart';

import 'package:xkcd/View/Widgets/custom_progress.dart';
import 'package:xkcd/View/screens/browse_comics_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AllComicProvider>().getAllComic();
      context.read<SavedComicProvider>().getSavedComics();
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    double widthMain = MediaQuery.of(context).size.width;

    var isLoading = context.watch<AllComicProvider>().isLoading;
    var allComic = context.watch<AllComicProvider>().allComic;
    var savedComic = context.watch<SavedComicProvider>().savedComics;
    return Container(
      child: Scaffold(
        appBar: newMethod(widthMain, tabController),
        //body: tabBodyBrowse(allComic),
        body: isLoading
            ? Center(
                child: customProgressWidget(),
              )
            : TabBarView(
                controller: tabController,
                children: [
                  //Center(child: Text("data")),
                  allComic.isEmpty
                      ? Center(
                          child: customProgressWidget(),
                        )
                      : BrowseComicScreen(
                          allComic: allComic,
                          savedComic: savedComic,
                        ),
                  Container(
                    alignment: Alignment.center,
                    //height: heightMain * .7,
                    child: savedComic.isEmpty
                        ? Container(
                            child: Text(
                              "No Saved Comics",
                              style: GoogleFonts.barlow(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        : ListView.builder(
                            //itemBuilder: _buildListItem,
                            itemBuilder: ((p0, index) {
                              return CustomCardComic(
                                allComic: savedComic[index],
                                savedComic: savedComic,
                              );
                            }),
                            itemCount: savedComic.length,
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  AppBar newMethod(
      double widthMain,  TabController tabController) {
    return AppBar(
      title: Text(
        "XKCD Comic App".toUpperCase(),
        style: GoogleFonts.barlow(
            fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true,
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: AnimSearchBar(
            closeSearchOnSuffixTap: true,
            helpText: "Enter a comic id or name ..",
            suffixIcon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            rtl: true,
            width: widthMain * .9,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            color: Colors.black,
            onSuffixTap: () {},
            style: GoogleFonts.barlow(
                fontWeight: FontWeight.w500, color: Colors.white),
            textController: textEditingController,
          ),
        ),
        //SizedBox(width: 10,),
      ],
      bottom: TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Browse".toUpperCase(),
                    style: GoogleFonts.barlow(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Saved".toUpperCase(),
                    style: GoogleFonts.barlow(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
