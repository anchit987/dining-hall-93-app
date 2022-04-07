import 'package:dining_hall/blocs/auth_bloc/auth_bloc.dart';
import 'package:dining_hall/presentation/cart/cart_screen.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/home/main_screen.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:dining_hall/presentation/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;
  final screens = [
    MainScreen(),
    CartScreen(),
    Container(),
    UserProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.unauthenticated:
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteList.signIn, (route) => false);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        // drawer: Drawer(),

        appBar: currentIndex == 0
            ? PreferredSize(
                preferredSize:
                    Size.fromHeight(getProportionateScreenHeight(80)),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.grey.shade100,
                  iconTheme: const IconThemeData(color: Colors.black),
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu, color: Colors.black),
                  ),
                  actions: [
                    // IconButton(
                    //   icon: const Icon(Icons.person),
                    //   onPressed: () {
                    //     Navigator.of(context).pushNamed(RouteList.profile);
                    //   },
                    // ),
                    IconButton(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutRequest());
                      },
                    ),
                  ],
                ),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
