import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:xkcd/Model/all_comic.dart';

class SharedPref {
  
  Future<void> addFavComic(List<AllComic> cList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('savedComics', jsonEncode(cList));
  }

  Future<List<AllComic>> getFavComic() async {
    List<AllComic> list = [];
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('savedComics') ?? '[]');

    list = jsonData.isEmpty
        ? []
        : jsonData.map<AllComic>((jsonItem) {
            return AllComic.fromJson(jsonItem);
          }).toList();

    return list;
  }

  Future<bool> checkIsFav(int index) async {
    bool isFav = false;
    List<AllComic> list = [];
    getFavComic().then((value) => list = value);

    isFav = list.any((element) {
      return element.id == index;
    });

    return isFav;
  }

  Future<void> removeFavComic(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<AllComic> list = [];
    final List<dynamic> jsonData =
        jsonDecode(prefs.getString('savedComics') ?? '[]');

    list = jsonData.isEmpty
        ? []
        : jsonData.map<AllComic>((jsonItem) {
            return AllComic.fromJson(jsonItem);
          }).toList();
    list.removeWhere((element) => element.id == index);

    prefs.setString('savedComics', jsonEncode(list));
  }
}
