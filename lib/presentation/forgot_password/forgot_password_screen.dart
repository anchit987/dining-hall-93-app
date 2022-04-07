import 'package:dining_hall/blocs/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/presentation/forgot_password/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getItInstance<ForgotPasswordCubit>(),
      child: const ForgotPasswordForm(),
    );
  }
}

