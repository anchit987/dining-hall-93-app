import 'package:dining_hall/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/presentation/sign_up/sign_up_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (_) => getItInstance<SignUpCubit>(),
      child: const SignUpForm(),
    );
  }
}
