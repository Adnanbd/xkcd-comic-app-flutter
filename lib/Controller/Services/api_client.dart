import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:xkcd/Model/all_comic.dart';



class ApiClient {
  //Base URL to fetch All Comics
  static const _allComicUrl = 'https://api.xkcdy.com/comics'; 

  Future<List<AllComic>?> fetchAllComic(int limit) async {

    var newClient = http.Client();
    try {
      final response = await newClient.get(Uri.parse(_allComicUrl));

      //If a succesful request is done
      if (response.statusCode == 200) {
        final allComic = allComicFromJson(response.body);
        return allComic;
      } 
      //If any problem occur during request
      else {
        if (kDebugMode) {
          print('fetchAllComic() Error ');
        }
        if (kDebugMode) {
          print('${response.statusCode}: ${response.body.toString()}');
        }
      }
    } finally {
      newClient.close();
    }

    return null;
  }
}
