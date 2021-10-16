// Flutter imports:
import 'package:finneasy/resources/colors.dart';
import 'package:finneasy/src/ui/home/model/blog_response.dart';
import 'package:finneasy/src/ui/home/store/home_store.dart';
import 'package:flutter/material.dart';


class Fweets extends StatelessWidget {
  final List<BlogResponse> blogs;
  final HomeStore store;
  const Fweets({Key? key, required this.blogs, required this.store}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          for (int i =0; i< blogs.length; i++)
              Container(
                width: screenWidth * 0.9,
                margin: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.02),
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
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                      blogs[i].publisher!.split(" ")[0][0].toUpperCase() + blogs[i].publisher!.split(" ")[1][0].toUpperCase()
                  )
                ),
                trailing: IconButton(
                  onPressed: (){
                    store.likeDislike(context, i, blogs[i].id!);
                  },
                  icon: Icon(
                    store.blogLikeDislike[i] ? Icons.thumb_up_alt_outlined : Icons.thumb_down_alt_outlined,
                    color: store.blogLikeDislike[i] ? AppColors.error : AppColors.grey,
                    size: screenWidth * 0.05,
                  ),
                ),
                title: Text(
                  blogs[i].title!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:Text(
                  "By - " + blogs[i].publisher! + "\n" + blogs[i].body!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ),
        ]
      ),
    );
  }
}
