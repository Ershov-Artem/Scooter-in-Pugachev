import 'package:flutter/material.dart';

@immutable
class CustomButton extends StatelessWidget {
  final Icon icon;
  final Function onTap;
  final double height;
  final double width;
  final BoxDecoration decoration;

  CustomButton(
      {@required this.onTap,
      @required this.icon,
      @required this.height,
      @required this.width,
      @required this.decoration});
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: decoration,
        child: icon,
      ));
}
