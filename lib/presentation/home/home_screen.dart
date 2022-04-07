import 'package:dining_hall/blocs/auth_bloc/auth_bloc.dart';
import 'package:dining_hall/blocs/cart_bloc/cart_bloc.dart';
import 'package:dining_hall/blocs/product_detail_bloc/product_detail_bloc.dart';
import 'package:dining_hall/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/home/main_screen.dart';
import 'package:dining_hall/presentation/home/menu_widget.dart';
import 'package:dining_hall/presentation/home/navigation_screen.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // AuthBloc? authBloc;
  late UserProfileBloc userProfileBloc;
  late ProductDetailBloc productDetailBloc;
  late CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    // authBloc = getItInstance<AuthBloc>();
    userProfileBloc = getItInstance<UserProfileBloc>();
    userProfileBloc.add(const UserProfileLoadEvent());
    productDetailBloc = getItInstance<ProductDetailBloc>();
    productDetailBloc.add(const ProductDetailLoadEvent());
    cartBloc = getItInstance<CartBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    // authBloc?.close();
    userProfileBloc.close();
    productDetailBloc.close();
    cartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => userProfileBloc),
        BlocProvider(create: (_) => productDetailBloc),
        BlocProvider(create: (_) => cartBloc),
      ],
      // child: BlocListener<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     switch (state.status) {
      //       case AuthStatus.unauthenticated:
      //         Navigator.of(context)
      //             .pushNamedAndRemoveUntil(RouteList.signIn, (route) => false);
      //         break;
      //       default:
      //         break;
      //     }
      //   },
      //   child: Scaffold(
      //     appBar: PreferredSize(
      //       preferredSize: Size.fromHeight(getProportionateScreenHeight(80)),
      //       child: AppBar(
      //         elevation: 0,
      //         backgroundColor: Colors.grey.shade100,
      //         iconTheme: const IconThemeData(color: Colors.black),
      //         leading: IconButton(
      //           onPressed: () {},
      //           icon: const Icon(Icons.menu, color: Colors.black),
      //         ),
      //         actions: [
      //           IconButton(
      //             icon: const Icon(Icons.person),
      //             onPressed: () {
      //               Navigator.of(context).pushNamed(RouteList.profile);
      //             },
      //           ),
      //           IconButton(
      //             icon: const Icon(Icons.exit_to_app),
      //             onPressed: () {
      //               authBloc?.add(AuthLogoutRequest());
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //     bottomNavigationBar: BottomNavigationBar(
      //       type: BottomNavigationBarType.fixed,
      //       currentIndex: currentIndex  ,
      //       // onTap: (index),
      //       selectedItemColor: kPrimaryColor,
      //       unselectedItemColor: Colors.grey,
            
      //       items: [
      //         BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.shopping_bag), label: "Cart"),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.favorite), label: "Favorite"),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.notification_important),
      //             label: "Notification"),
      //       ],
      //     ),
      //     body: const MainScreen(),
      //   ),
      // ),
      
      child: NavigationScreen(),
    );
  }
}

