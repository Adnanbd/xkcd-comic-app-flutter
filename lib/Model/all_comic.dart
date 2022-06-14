// To parse this JSON data, do
//
//     final allComic = allComicFromJson(jsonString);

import 'dart:convert';

List<AllComic> allComicFromJson(String str) => List<AllComic>.from(json.decode(str).map((x) => AllComic.fromJson(x)));

String allComicToJson(List<AllComic> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllComic {
    AllComic({
        required this.id,
        required this.publishedAt,
        required this.news,
        required this.safeTitle,
        required this.title,
        required this.transcript,
        required this.alt,
        required this.sourceUrl,
        required this.explainUrl,
        required this.interactiveUrl,
        required this.imgs,
    });

    int id;
    DateTime publishedAt;
    String news;
    String safeTitle;
    String title;
    String transcript;
    String alt;
    String sourceUrl;
    String explainUrl;
    dynamic interactiveUrl;
    List<Img> imgs;

    factory AllComic.fromJson(Map<String, dynamic> json) => AllComic(
        id: json["id"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        news: json["news"],
        safeTitle: json["safeTitle"],
        title: json["title"],
        transcript: json["transcript"],
        alt: json["alt"],
        sourceUrl: json["sourceUrl"],
        explainUrl: json["explainUrl"],
        interactiveUrl: json["interactiveUrl"],
        imgs: List<Img>.from(json["imgs"].map((x) => Img.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "publishedAt": publishedAt.toIso8601String(),
        "news": news,
        "safeTitle": safeTitle,
        "title": title,
        "transcript": transcript,
        "alt": alt,
        "sourceUrl": sourceUrl,
        "explainUrl": explainUrl,
        "interactiveUrl": interactiveUrl,
        "imgs": List<dynamic>.from(imgs.map((x) => x.toJson())),
    };
}

class Img {
    Img({
        required this.height,
        required this.width,
        required this.ratio,
        required this.sourceUrl,
        required this.size,
    });

    int height;
    int width;
    double ratio;
    String sourceUrl;
    String size;

    factory Img.fromJson(Map<String, dynamic> json) => Img(
        height: json["height"],
        width: json["width"],
        ratio: json["ratio"].toDouble(),
        sourceUrl: json["sourceUrl"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
        "ratio": ratio,
        "sourceUrl": sourceUrl,
        "size": size,
    };
}
