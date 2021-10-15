import 'package:finneasy/src/widget/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, String url) async =>
    await canLaunch(url) ? await launch(url) : showFlushBar(context, 'Could not launch $url');