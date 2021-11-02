import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class Webview extends StatefulWidget {
  Webview(this.url);
  String url;
  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
      child: WebView(
        initialUrl: widget.url,
        debuggingEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          launch(request.url);
          print(request.url);
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
