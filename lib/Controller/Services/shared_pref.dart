import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:xkcd/Model/all_comic.dart';

// This class is using for saving and retrieving comics locally
class SharedPref {
  
  // Saving Updated Saved Comic list 
  Future<void> addFavComic(List<AllComic> cList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('savedComics', jsonEncode(cList));
  }
  //Get saved comics
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

  // Removing comic from saved comic list
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
