import 'package:dining_hall/presentation/constants/route_constants.dart';

import '../constants/constants.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //? NAVIGATION
  void _onIntroEnd(context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteList.signIn,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    dynamic titleTextStyle = TextStyle(
      fontSize: getProportionateScreenHeight(32),
      fontWeight: FontWeight.bold,
      color: kPrimaryColorOpacity80,
    );
    dynamic bodyStyle = const TextStyle(
      fontSize: 19.0,
      color: Colors.black54,
    );
    dynamic pageDecoration = PageDecoration(
      titleTextStyle: titleTextStyle,
      bodyTextStyle: bodyStyle,
      descriptionPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    dynamic intro_3_padding = getProportionateScreenHeight(40);
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        color: kPrimaryColorOpacity80,
        globalFooter: SizedBox(
          width: double.infinity,
          height: getProportionateScreenHeight(60),
          child: ElevatedButton(
            child: const Text(
              'Let\'s go right away!',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(kPrimaryColor),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Order Your Food",
            body: "Now you can order food any time right from your mobile.",
            image: Image.asset("assets/images/intro_1.png"),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Clean, Hygiene And Safe Food",
            body: "We maintain safty and We keep clean while making food.",
            image: Image.asset("assets/images/intro_2.png"),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Enjoy Your Food",
            body: "Enjoy your ordered food in the Dining Hall'83",
            image: Padding(
              padding: EdgeInsets.fromLTRB(
                  intro_3_padding, intro_3_padding, intro_3_padding, 0),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(20)),
                child: Image.asset("assets/images/intro_3.jpg"),
              ),
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: true,
        showNextButton: true,
        showDoneButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.bold)),
        next: const Icon(Icons.arrow_forward_sharp),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
        //
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: kPrimaryColorOpacity50,
          activeSize: Size(22.0, 10.0),
          activeColor: kPrimaryColor,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
