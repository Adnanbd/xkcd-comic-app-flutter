import 'package:flutter/material.dart';
import 'package:xkcd/Model/all_comic.dart';
import 'package:xkcd/Controller/Services/api_client.dart';
import 'package:xkcd/Model/all_comic.dart';

class AllComicProvider with ChangeNotifier {
  bool _isLoading = true;

  List<AllComic> _allComic = [];

  ApiClient apiClient = ApiClient();

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }



  List<AllComic> get allComic => _allComic;

  

  void getAllComic() {
    setLoading(true);
    apiClient.fetchAllComic(0).then((value) {
      _allComic = value!.reversed.toList();
      setLoading(false);
    });

    notifyListeners();
  }


}
