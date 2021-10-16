import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/widget/appbar.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPageView extends StatefulWidget {
  final String title;
  final String url;
  final Icon? icon;
  final Widget? widget;

  const WebPageView({Key? key, required this.title, required this.url, this.icon, this.widget}) : super(key: key);

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
      ),
        bottomNavigationBar: widget.widget
    );
  }
}