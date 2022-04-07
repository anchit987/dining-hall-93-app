import '../blocs/auth_bloc/auth_bloc.dart';
import '../di/get_it.dart';
import 'constants/constants.dart';
import 'constants/route_constants.dart';
import 'route_generator.dart';
import 'sign_up/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;
  @override
  void initState() {
    super.initState();
    authBloc = getItInstance<AuthBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    authBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => authBloc,
        ),
      ],
      child: MaterialApp(
        title: "Dining Hall'83",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch(accentColor: kPrimaryColorOpacity30),
          // inputDecorationTheme: const InputDecorationTheme(

          //   border: OutlineInputBorder(
          //       borderSide: BorderSide(color: kPrimaryColor)),
          //   focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: kPrimaryColor)),
          //   enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: kPrimaryColor)),
          //   errorBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: kPrimaryColor)),
          //   focusedErrorBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: kPrimaryColor)),
          // ),
        ),
        initialRoute: RouteList.initial,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
