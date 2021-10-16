// Flutter imports:
import 'dart:math';

import 'package:finneasy/src/widget/list_cell.dart';
import 'package:flutter/material.dart';


class Rewards extends StatefulWidget {
  final dynamic rewards = [];

  Rewards({Key? key}) : super(key: key);

 
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column (
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          widget.rewards.length! != 0 ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                 for(int i = 0; i < min(widget.rewards.totalResults!, 10); i++)
                  ListCell(
                    image_url: widget.rewards.articles![i].urlToImage!,
                    headline: widget.rewards.articles![i].title!,
                    news_url: widget.rewards.articles![i].url!,
                    time: widget.rewards.articles![i].publishedAt!,
                    news: widget.rewards.articles![i].description!,
                  )
                ]
              )
            ) : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/notification.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
          child: null)
        ],
          ),
      );
  }
}
