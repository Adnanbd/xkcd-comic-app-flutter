import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:xkcd/View/Widgets/custom_progress.dart';

class ExplanationScreen extends StatefulWidget {
  final String url;
  const ExplanationScreen({super.key, required this.url});
  @override
  ExplanationScreenState createState() => ExplanationScreenState();
}

class ExplanationScreenState extends State<ExplanationScreen> {
  bool isLoading = true;
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    double heightMain = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        //Loading WebView to load the explanation url
        WebView(
          key: _key,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
        //Showing Progress Screen while loading the url
            ? Container(
              height: heightMain,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                  child: customProgressWidget(),
                ),
            )
            : Stack(),
      ],
    );
  }
}
