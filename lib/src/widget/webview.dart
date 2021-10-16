import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'appbar.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebPageView extends StatefulWidget {
  final String title;
  final String url;
  final Icon? icon;
  final Widget? widget;

  const WebPageView({Key? key, required this.title, required this.url, this.icon, this.widget}) : super(key: key);

  @override
  WebPageViewState createState() => WebPageViewState();
}

class WebPageViewState extends State<WebPageView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar(
        title: widget.title
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async{
        await showDialog(
            context: context,
            builder: (context) =>  widget.widget!);
      },
      child: Icon(
          Icons.shopping_bag_outlined
      ),
    ),
    body: Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
          ),
      ],
    )
    );
  }
}