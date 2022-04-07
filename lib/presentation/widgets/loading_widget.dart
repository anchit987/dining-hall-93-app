import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: const Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      ),
    );
  }
}
