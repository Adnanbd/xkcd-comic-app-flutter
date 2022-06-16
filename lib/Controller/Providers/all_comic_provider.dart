import 'package:flutter/material.dart';

import 'package:xkcd/Controller/Services/api_client.dart';
import 'package:xkcd/Model/all_comic.dart';

class AllComicProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _isSearchMode = false;

  List<AllComic> _allComic = [];
  List<AllComic> _searchedComics = [];

  ApiClient apiClient = ApiClient();

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }



  List<AllComic> get allComic => _allComic;

  List<AllComic> get searchedComics => _searchedComics;

  bool get isSearchMode => _isSearchMode;

  void setSearchMode(bool search) {
    _isSearchMode = search;
    notifyListeners();
  }
// This function returned ALL available comics
  void getAllComic() {
    setLoading(true);
    apiClient.fetchAllComic(0).then((value) {
      _allComic = value!.reversed.toList();
      setLoading(false);
    });

    notifyListeners();
  }

  

 // This function returned the comics that matched with search query
  void getSearchedComics(String enteredKeyword) {
    setLoading(true);
    List<AllComic> results = [];
    List<AllComic> tempList = [];
    // If user type any comic number
    if (isNumeric(enteredKeyword)) {
      int temp = int.parse(enteredKeyword);
      results = _allComic.where((comic) => comic.id == temp).toList();
      tempList = _allComic
          .where((comic) =>
              comic.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      results = results + tempList;
    } 
    // If user type any comic name/title
    else {
      results = _allComic
          .where((comic) =>
              comic.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    _searchedComics = results;
    setLoading(false);
    notifyListeners();
  }
// Clean the Searched Comic List for next search
  void cleanSearchedComic() {
    _searchedComics = [];
    notifyListeners();
  }

   bool isNumeric(String s) {
    return int.tryParse(s) != null;
  }

}
