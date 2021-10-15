// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/utils/url_launcher.dart';
import 'package:finneasy/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';


// Package imports:

class ListCell extends StatelessWidget {
  final String headline;
  final String news;
  final String time;
  final String image_url;
  final String news_url;

  const ListCell({
    Key? key,
    required this.headline,
    required this.news,
    required this.time,
    required this.image_url,
    required this.news_url}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Stack(
        children: <Widget>[
          Container(
            width: screenWidth * 0.9,
            padding: EdgeInsets.only(
              top: 18.0,
            ),
            margin: EdgeInsets.only(top: 13.0),
            decoration: BoxDecoration(
                color: Theme.of(context).selectedRowColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                    width: 1.5,
                    color: AppColors.black
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context).selectedRowColor,
                    blurRadius: 0.0,
                  ),
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5, right: 5),
                    child: Image(
                      image: NetworkImage(image_url),
                      width: 50,
                      height: 100
                    )
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: RichText(
                        maxLines : 10,
                        text: TextSpan(
                          semanticsLabel: "news",
                          text: headline + '\n',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 0.04 * screenWidth,
                              fontWeight: FontWeight.bold
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: news + '\n',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 0.03 * screenWidth,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
          Positioned(
            right: 10.0,
            top: 10,
            child: Align(
              alignment: Alignment.topRight,
              child: RoundedButton(
                onTap: () {
                  launchURL(context, news_url);
                },
                width: screenWidth * 0.3,
                height: screenWidth * 0.06,
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderColor: AppColors.primaryColor,
                splashColor: AppColors.white,
                blurRadius: 0,
                child: Text(
                    "READ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.white, fontSize: 0.03 * screenWidth, fontWeight: FontWeight.bold
                    )
                ),
              ),
            ),
          ),
        ]
    );
  }
}