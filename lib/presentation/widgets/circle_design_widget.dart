import '../constants/constants.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';

class CircleDesignWidget extends StatelessWidget {
  const CircleDesignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        Positioned(
              top: -getProportionateScreenHeight(75),
              left: -getProportionateScreenHeight(75),
              child: Container(
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenHeight(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: kPrimaryColor,
                ),
              ),
            ),
            Positioned(
              top: -getProportionateScreenHeight(200) / 2,
              left: 0,
              child: Container(
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenHeight(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kPrimaryColorOpacity30,
                ),
              ),
            ),
            Positioned(
              top: -getProportionateScreenHeight(75/2),
              left: -getProportionateScreenHeight(75/2),
              child: Container(
                height: getProportionateScreenHeight(75),
                width: getProportionateScreenHeight(75),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: -getProportionateScreenHeight(150/2),
              right: -getProportionateScreenHeight(150/2),
              child: Container(
                height: getProportionateScreenHeight(150),
                width: getProportionateScreenHeight(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: kPrimaryColor,
                ),
              ),
            ),
      ],
    );
  }
}
