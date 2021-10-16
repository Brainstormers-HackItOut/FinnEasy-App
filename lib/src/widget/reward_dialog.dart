
import 'package:finneasy/resources/colors.dart';
import 'package:flutter/material.dart';

Future<void> showRewardDialog(BuildContext context, int coins) async {
  await showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        title:  const CircleAvatar(
          radius: 45,
          child: Image(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter
          ),
        ),
        content: Text(
          "Congratulations you have earn $coins coins.",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColor
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
            ),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Woohooo!', style: TextStyle(color: AppColors.white),),
          ),
        ],
      ),
  );
}