import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'package:xkcd/Controller/Providers/all_comic_provider.dart';

import 'package:xkcd/View/Widgets/custom_progress.dart';
import 'package:xkcd/View/screens/browse_comics_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  
 

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AllComicProvider>().getAllComic();
     

      
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    double widthMain = MediaQuery.of(context).size.width;

    var isLoading = context.watch<AllComicProvider>().isLoading;
    var allComic = context.watch<AllComicProvider>().allComic;

    return Container(
      child: Scaffold(
        appBar: AppBar(),
        //body: tabBodyBrowse(allComic),
        body: isLoading
            ? Center(
                child: customProgressWidget(),
              )
            :TabBarView(
                    controller: tabController,
                    children: [
                      //Center(child: Text("data")),
                      allComic.isEmpty
                          ? Center(
                              child: customProgressWidget(),
                            )
                          : BrowseComicScreen(
                              allComic: allComic),
                      Container(),
                    ],
                  ),
      ),
    );
  }

}
