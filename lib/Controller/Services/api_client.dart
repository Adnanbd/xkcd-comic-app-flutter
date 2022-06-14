import 'package:http/http.dart' as http;

import 'package:xkcd/Model/all_comic.dart';



class ApiClient {
  static const _allComicUrl = 'https://api.xkcdy.com/comics';

  Future<List<AllComic>?> fetchAllComic(int limit) async {

    var newClient = http.Client();
    try {
      final response = await newClient.get(Uri.parse(_allComicUrl));

      if (response.statusCode == 200) {
        final allComic = allComicFromJson(response.body);
        return allComic;
      } else {
        print('fetchAllComic() Error ');
        print('${response.statusCode}: ${response.body.toString()}');
      }
    } finally {
      newClient.close();
    }

    return null;
  }
}
