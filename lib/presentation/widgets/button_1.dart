import '../constants/constants.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String? title;
  final double? height;
  final double? width;
  final Function? onTap;
  const Button1({
    Key? key,
    @required this.title,
    @required this.height,
    @required this.width,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryColor,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: kPrimaryColorOpacity80,
        ),
        child: Align(
          child: Text(
            title ?? "Submit",
            style:const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () => onTap,
    );
  }
}
