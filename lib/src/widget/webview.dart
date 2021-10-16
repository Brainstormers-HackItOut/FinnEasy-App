import 'package:finneasy/src/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPageView extends StatefulWidget {
  final String title;
  final String url;
  final Icon? icon;
  final Function? function;

  const WebPageView({Key? key, required this.title, required this.url, this.icon, this.function}) : super(key: key);

  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      withZoom: true,
      appBar: Appbar(
        title: widget.title,
        trailingFunction: widget.function,
        trailingIcon: widget.icon,
      ),
    );
  }
}