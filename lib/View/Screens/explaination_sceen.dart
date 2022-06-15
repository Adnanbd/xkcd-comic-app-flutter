import 'dart:io';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ExplainationScreen extends StatefulWidget {
  String url;
  ExplainationScreen({super.key, required this.url});
  @override
  ExplainationScreenState createState() => ExplainationScreenState();
}

class ExplainationScreenState extends State<ExplainationScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
    );
  }
}
