import 'package:dining_hall/blocs/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:dining_hall/domain/entities/errors/auth_error.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:dining_hall/presentation/widgets/circle_design_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Password reset email sent successfully')),
            );
        } else if (state.status.isSubmissionFailure) {
          AuthErrorType authErrorType = state.authError.authErrorType;
          if (authErrorType == AuthErrorType.userNotFound) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('User not found!')),
              );
          } else {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Something Went To Wrong!!!')),
              );
          }
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(100),
                width: SizeConfig.screenWidth,
                child: Stack(
                  children: [
                    const CircleDesignWidget(),
                    Positioned(
                      top: getProportionateScreenHeight(20),
                      left: getProportionateScreenWidth(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(10)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_rounded),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(36),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      "Enter your e-mail to send the mail to reset password",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          color: Colors.grey),
                    ),
                    _EmailInput(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    _ResetPasswordButton(),
                  ],
                ),
              ),
              // _EmailInput(),
            ],
          ),
        ),
      ),
    ));
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('forgotPasswordForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<ForgotPasswordCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              )
            : InkWell(
                key: const Key('resetPasswordForm_continue_Button'),
                splashColor: kPrimaryColor,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kPrimaryColor,
                  ),
                  child: const Align(
                    child: Text(
                      "Send Link To Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (state.status.isValidated) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    context
                        .read<ForgotPasswordCubit>()
                        .sendResetPasswordEmail();
                  } else {
                    null;
                  }
                },
              );
      },
    );
  }
}
