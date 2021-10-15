// Flutter imports:
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  final double height;
  final double width;
  final Color color;
  final Color borderColor;
  final Widget child;
  final GestureTapCallback onTap;
  final BorderRadius borderRadius;
  final Color splashColor;
  final double blurRadius;

  RoundedButton({required this.height, required this.width, required this.color, required this.child, required this.onTap, required this.borderRadius, required this.splashColor, required this.blurRadius, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: borderRadius,
            splashColor: splashColor,
            onTap: onTap,
            child:  Center(
              child: child,
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius:borderRadius,
        border: Border.all(
            width: 1.5,
            color: borderColor
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color,
            blurRadius: blurRadius,
            offset: const Offset(0.0, 0.0),
          ),
        ],
      ),
    );
  }
}