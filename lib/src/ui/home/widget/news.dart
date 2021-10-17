// Flutter imports:
import 'dart:math';

import 'package:finneasy/src/core/network_state/network_state.dart';
import 'package:finneasy/src/ui/home/model/fin_news.dart';
import 'package:finneasy/src/widget/list_cell.dart';
import 'package:finneasy/src/widget/observer_network_state.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';

// Project imports:

class News extends StatefulWidget {
  FinNews news;
  News({Key? key, required this.news}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {

  @override
  void initState() {
    super.initState();
    initstate();
  }
  
  initstate() async{
    print(widget.news);
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Column (
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          widget.news.totalResults! != 0 ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                 for(int i = 0; i < min(widget.news.totalResults!, 5); i++)
                  ListCell(
                    image_url: widget.news.articles![i].urlToImage!,
                    headline: widget.news.articles![i].title!,
                    news_url: widget.news.articles![i].url!,
                    time: widget.news.articles![i].publishedAt!,
                    news: widget.news.articles![i].description!,
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
