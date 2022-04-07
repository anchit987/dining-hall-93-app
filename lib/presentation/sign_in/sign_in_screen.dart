import 'package:dining_hall/blocs/sign_in_cubit/sign_in_cubit.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/presentation/sign_in/sign_in_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (_) => getItInstance<SignInCubit>(),
      child: const SignInForm(),
    );
  }
}
