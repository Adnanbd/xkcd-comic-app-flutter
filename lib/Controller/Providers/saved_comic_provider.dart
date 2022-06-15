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

  void getSavedComics() {
    setLoading(true);

    sharedPref.getFavComic().then((value) {
      _savedComics = value.toList();

      setLoading(false);
    });

    notifyListeners();
  }

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

  void addSavedComics(AllComic comic) {
    setLoading(true);

    _savedComics.insert(0, comic);
    //_savedComics = _savedComics.reversed.toList();

    sharedPref.addFavComic(_savedComics).then((_) {
      setLoading(false);
    });

    notifyListeners();
  }

}
