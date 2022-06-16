import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import 'package:xkcd/Controller/Providers/all_comic_provider.dart';
import 'package:xkcd/Controller/Providers/saved_comic_provider.dart';
import 'package:xkcd/Controller/Services/shared_pref.dart';
import 'package:xkcd/View/Screens/saved_comic_screen.dart';
import 'package:xkcd/View/Screens/searched_comic_screen.dart';
import 'package:xkcd/View/Widgets/custom_progress.dart';
import 'package:xkcd/View/screens/browse_comics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  SharedPref sharedPref = SharedPref();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      //Fetching All Comics from Base Api ...
      context.read<AllComicProvider>().getAllComic();
      //Fetching Local Saved Comics ...
      context.read<SavedComicProvider>().getSavedComics();

      //Added a listener to Search Textfield ...
      textEditingController.addListener(() {
        if (textEditingController.text.isEmpty) {
          //Search Mode OFF
          context.read<AllComicProvider>().setSearchMode(false);
          context.read<AllComicProvider>().cleanSearchedComic();
        } else {
          //Performing search with provided id or name ...
          context
              .read<AllComicProvider>()
              .getSearchedComics(textEditingController.text);
          //Search Mode ON
          context.read<AllComicProvider>().setSearchMode(true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    double widthMain = MediaQuery.of(context).size.width;

    var isLoading = context.watch<AllComicProvider>().isLoading;
    var isSearchMode = context.watch<AllComicProvider>().isSearchMode;

    //All Comics storing here ...
    var allComic = context.watch<AllComicProvider>().allComic;
    //All Saved Comics storing here ...
    var savedComic = context.watch<SavedComicProvider>().savedComics;
    //All Searched Comics storing here ...
    var searchedComic = context.watch<AllComicProvider>().searchedComics;

    return Scaffold(
      appBar: newMethod(widthMain, isSearchMode, tabController),
      body: isLoading
          ? Center(
              child: customProgressWidget(),
            )
          : isSearchMode
              ? SearchedComicScreen(
                  searchedComic: searchedComic,
                  savedComic: savedComic,
                )
              :
              //Main HomeScreen View when no search query is occuring ...
              TabBarView(
                  controller: tabController,
                  children: [
                    BrowseComicScreen(
                      allComic: allComic,
                      savedComic: savedComic,
                    ),
                    SavedComicScreen(
                      savedComic: savedComic,
                    ),
                  ],
                ),
    );
  }

//Custom AppBar with Tabbar ...
  AppBar newMethod(
      double widthMain, bool isSearchMode, TabController tabController) {
    return AppBar(
      //AppBar Heading
      title: Text(
        "XKCD Comic App".toUpperCase(),
        style: GoogleFonts.barlow(
            fontWeight: FontWeight.bold, color: Colors.black),
      ),
      centerTitle: true, //Make the title centered
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: AnimSearchBar(
            //Custom Search Bar
            closeSearchOnSuffixTap: true,
            helpText: "Enter a comic id or name ..",
            suffixIcon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            rtl: true,
            width: widthMain * .9,
            textController: textEditingController,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            color: Colors.black,
            onSuffixTap: () {
              setState(() {
                textEditingController.clear();
              });
            },
            style: GoogleFonts.barlow(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
      bottom: isSearchMode
          ?
          //When Search Mode in on, then no tabbar is needed to show
          PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(),
            )
          :
          //Tababr for easy navigation with swipe
          TabBar(
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
