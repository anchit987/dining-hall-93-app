import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/presentation/checkout/checkout_screen.dart';
import 'package:dining_hall/presentation/contact_us/contact_us_screen.dart';
import 'package:dining_hall/presentation/forgot_password/forgot_password_screen.dart';
import 'package:dining_hall/presentation/home/home_screen.dart';
import 'package:dining_hall/presentation/intro_screen/intro_screen.dart';
import 'package:dining_hall/presentation/product_detail/product_detail_screen.dart';
import 'package:dining_hall/presentation/user_profile/current_order_screen.dart';
import 'package:dining_hall/presentation/user_profile/user_profile_screen.dart';

import 'app_view.dart';
import 'constants/route_constants.dart';
import 'sign_in/sign_in_screen.dart';
import 'sign_up/sign_up_screen.dart';
import 'splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case RouteList.initial:
        return MaterialPageRoute(builder: (_) => const AppView());
      case RouteList.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteList.intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case RouteList.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case RouteList.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteList.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteList.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteList.profile:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case RouteList.productDetail:
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailScreen(product: (args as ProductEntity)));
      case RouteList.checkOut:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case RouteList.currentOrder:
        return MaterialPageRoute(builder: (_) => CurrentOrderScreen());
      case RouteList.contactUs:
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
    }
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
