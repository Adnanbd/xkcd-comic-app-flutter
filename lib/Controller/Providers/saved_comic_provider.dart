import 'package:flutter/material.dart';

import 'package:xkcd/Controller/Services/shared_pref.dart';
import 'package:xkcd/Model/all_comic.dart';

class SavedComicProvider extends ChangeNotifier {

  SharedPref sharedPref = SharedPref();

  List<AllComic> _savedComics = [];

  List<AllComic> get savedComics => _savedComics;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
// Get Comic list those were already saved
  void getSavedComics() {
    setLoading(true);

    sharedPref.getFavComic().then((value) {
      _savedComics = value.toList();

      setLoading(false);
    });

    notifyListeners();
  }
// Remove comics from Saved Comic List
  void removeSavedComics(int index) {
    setLoading(true);

    sharedPref.removeFavComic(index).then((_) {
      sharedPref.getFavComic().then((value) {
        _savedComics = value;
        setLoading(false);
      });
    });

    notifyListeners();
  }
// Add a new comic to Saved Comic List
  void addSavedComics(AllComic comic) {
    setLoading(true);

    _savedComics.insert(0, comic);
    sharedPref.addFavComic(_savedComics).then((_) {
      setLoading(false);
    });

    notifyListeners();
  }

}
