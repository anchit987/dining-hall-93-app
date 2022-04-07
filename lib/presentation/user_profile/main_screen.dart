import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dining_hall/blocs/auth_bloc/auth_bloc.dart';
import 'package:dining_hall/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:dining_hall/presentation/widgets/circle_design_widget.dart';
import 'package:dining_hall/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  UserProfileBloc? _userProfileBloc;
  @override
  void initState() {
    super.initState();
    _userProfileBloc = getItInstance<UserProfileBloc>();
    _userProfileBloc?.add(const UserProfileLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _userProfileBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        bloc: _userProfileBloc,
        builder: (context, state) {
          if (state is UserProfileInitial || state is UserProfileLoading) {
            return const LoadingWidget();
          } else if (state is UserProfileError) {
            return Scaffold(
              body: Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Text("something went wrong"),
                ),
              ),
            );
          } else if (state is UserProfileLoaded) {
            print(state.userEntity.toString());
            return SingleChildScrollView(
              child: Container(
                height: SizeConfig.screenHeight,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(100),
                      width: SizeConfig.screenWidth,
                      child: Stack(
                        children: [
                          const CircleDesignWidget(),
                          // Positioned(
                          //   top: getProportionateScreenHeight(20),
                          //   left: getProportionateScreenWidth(20),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(
                          //           getProportionateScreenHeight(10)),
                          //     ),
                          //     child: IconButton(
                          //       onPressed: () {
                          //         SystemChannels.textInput
                          //             .invokeMethod('TextInput.hide');
                          //         Navigator.of(context).pop();
                          //       },
                          //       icon: const Icon(Icons.arrow_back_ios_rounded),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                        backgroundColor: kPrimaryColorOpacity80,
                        radius: getProportionateScreenWidth(40),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      (state.userEntity.username?.toUpperCase() ?? ""),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      (state.userEntity.email ?? ""),
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    InkWell(
                      onTap: () {},
                      splashColor: kPrimaryColor,
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(50)),
                    _Button2(
                      () {
                                                Navigator.of(context).pushNamed(RouteList.currentOrder);
                      },
                      name: "Current Orders",
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    _Button2(() {}, name: "Orders History"),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    _Button2(() {
                      Navigator.of(context).pushNamed(RouteList.contactUs);
                    }, name: "Contact Us"),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    _Button2(() {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          headerAnimationLoop: false,
                          animType: AnimType.TOPSLIDE,
                          showCloseIcon: true,
                          closeIcon: Icon(Icons.close),
                          title: 'Logout',
                          desc: 'Do you want to Logout?',
                          btnCancelOnPress: () {},
                          onDissmissCallback: (type) {
                            // debugPrint('Dialog Dissmiss from callback $type');
                          },
                          btnOkOnPress: () {
                            context.read<AuthBloc>().add(AuthLogoutRequest());
                          })
                        ..show();
                    }, name: "Log Out"),
                  ],
                ),
              ),
            );
          }
          return LoadingWidget();
        },
      ),
    );
  }
}

class _Button2 extends StatelessWidget {
  final String? name;
  final Function onTapFunc;

  const _Button2(
    this.onTapFunc, {
    Key? key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(25)),
      child: InkWell(
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Align(
              child: Text(
                name ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          onTap: () {
            onTapFunc();
          }),
    );
  }
}
