import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, String url) async{
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showFlushBar(context, 'Could not launch $url');
  }
}
