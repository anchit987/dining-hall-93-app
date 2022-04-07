import 'package:dining_hall/blocs/auth_bloc/auth_bloc.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        switch (state.status) {
          case AuthStatus.authenticated:
            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteList.home, (route) => false);
            break;

          case AuthStatus.unauthenticated:
            await Future.delayed(const Duration(seconds: 2));
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteList.intro, (route) => false);
            break;

          default:
            break;
        }
      },
      child: const SplashScreen(),
    );
  }
}
