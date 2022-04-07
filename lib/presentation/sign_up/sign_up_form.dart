import 'package:dining_hall/blocs/auth_bloc/auth_bloc.dart';
import 'package:dining_hall/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:dining_hall/domain/entities/errors/auth_error.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:dining_hall/presentation/widgets/circle_design_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

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
        BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              AuthErrorType _authErrorType = state.authError.authErrorType;
              if (_authErrorType == AuthErrorType.emailAlreadyInUse) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Email is already in use')),
                  );
              } else {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Sign Up Failure')),
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
                        "Sign Up",
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(36),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Text(
                        "Username",
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                            color: Colors.grey),
                      ),
                      _UsernameInput(),
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
                      _SignupButton(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(RouteList.signIn);
                            },
                            child: const Text(
                              "Login",
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

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_usernameInput_textField'),
          onChanged: (email) =>
              context.read<SignUpCubit>().usernameChanged(email),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'username',
            helperText: '',
            errorText: state.email.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              )
            : InkWell(
                key: const Key('signUpForm_continue_Button'),
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
                      "Sign Up",
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
                    context.read<SignUpCubit>().signUpFormSubmitted();
                  } else {
                    null;
                  }
                },
              );
      },
    );
  }
}
