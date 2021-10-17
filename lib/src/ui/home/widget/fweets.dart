// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/home/model/blog_response.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';


class Fweets extends StatelessWidget {
  final List<BlogResponse> blogs;
  final HomeStore store;
  const Fweets({Key? key, required this.blogs, required this.store}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Observer(
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              for (int i =0; i< blogs.length; i++)
                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.014),
                    margin: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.024),
                    decoration: BoxDecoration(
                      color: Theme.of(context).selectedRowColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        width: 1.5,
                        color: AppColors.black
                      ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                                blogs[i].publisher!.split(" ")[0][0].toUpperCase() + blogs[i].publisher!.split(" ")[1][0].toUpperCase()
                            )
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: (){
                                  store.likeDislike(context, i, blogs[i].id!);
                                },
                                icon: Icon(
                                  store.blogLikeDislike[i] ? Icons.star : Icons.star_border,
                                  color: store.blogLikeDislike[i] ? AppColors.error : AppColors.grey,
                                  size: screenWidth * 0.055,
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            blogs[i].title!,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle:RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: blogs[i].body! + "\n",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: "By - " + blogs[i].publisher! ,
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  ),
              ),
            ]
          ),
        );
      }
    );
  }
}
