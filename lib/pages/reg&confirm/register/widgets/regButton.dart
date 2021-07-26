import 'package:flutter/material.dart';

@immutable
class RegButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double height;
  final double width;
  final BoxDecoration decoration;

  RegButton(
      {@required this.onTap,
      @required this.height,
      @required this.width,
      @required this.text,
      @required this.decoration});
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          decoration: decoration,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: Theme.of(context).textTheme.button,
              textAlign: TextAlign.center,
            ),
          )));
}
