import 'package:dining_hall/blocs/auth_bloc/auth_bloc.dart';
import 'package:dining_hall/blocs/sign_in_cubit/sign_in_cubit.dart';
import 'package:dining_hall/domain/entities/errors/auth_error.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:dining_hall/presentation/widgets/circle_design_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RouteList.home, (route) => false);
                break;
              default:
                break;
            }
          },
        ),
        BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              AuthErrorType _authErrorType = state.authError.authErrorType;
              if (_authErrorType == AuthErrorType.emailOrPasswordNotMatch) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text("Email or password is wrong")),
                  );
              } else if (_authErrorType == AuthErrorType.userDisabled) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('User disabled')),
                  );
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Fail to sign in')),
                  );
              }
            }
          },
        ),
      ],
      //? UI
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(100),
                  width: SizeConfig.screenWidth,
                  child: const CircleDesignWidget(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(36),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Text(
                        "E-mail",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                            color: Colors.grey),
                      ),
                      _EmailInput(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                            color: Colors.grey),
                      ),
                      _PasswordInput(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      //? FORGOT PASSWORD
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(RouteList.forgotPassword);
                          },
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              kPrimaryColorOpacity30,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      _LoginButton(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(RouteList.signUp);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                kPrimaryColorOpacity30,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<SignInCubit>().emailChanged(email),
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignInCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              )
            : InkWell(
                key: const Key('loginForm_continue_Button'),
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
                      "Sign In",
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
                    context.read<SignInCubit>().signInFormSubmitted();
                  } else {
                    null;
                  }
                },
              );
      },
    );
  }
}
