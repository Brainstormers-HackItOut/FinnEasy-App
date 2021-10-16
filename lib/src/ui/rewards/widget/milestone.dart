// Flutter imports:
import 'dart:math';

import 'package:finneasy/src/ui/rewards/model/reward.dart';
import 'package:finneasy/src/widget/cards.dart';
import 'package:finneasy/src/widget/list_cell.dart';
import 'package:flutter/material.dart';


class Milestone extends StatefulWidget {
  final List<Reward> rewards;

  Milestone({Key? key, required this.rewards}) : super(key: key);

 
  @override
  _MilestoneState createState() => _MilestoneState();
}

class _MilestoneState extends State<Milestone> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return
          widget.rewards.isNotEmpty ?
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.rewards.length,
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035, vertical: screenHeight * 0.035),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: screenWidth * 0.42,
                      mainAxisSpacing: screenHeight * 0.035,
                      crossAxisSpacing: screenHeight * 0.035,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Cards(
                          color: Theme.of(context).cardColor,
                          text: widget.rewards[index].title.toString(),
                          coins: widget.rewards[index].coins.toString(),
                          description: widget.rewards[index].description!,
                      );
                    }


            ) : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/notification.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
          child: null
      );
  }
}
