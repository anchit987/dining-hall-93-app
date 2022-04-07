import 'package:bloc/bloc.dart';
import '../../domain/entities/errors/auth_error.dart';
import '../../domain/entities/input_entities/email.dart';
import '../../domain/entities/input_entities/name.dart';
import '../../domain/entities/input_entities/password.dart';
import '../../domain/usecases/auth/sign_up_user.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUser _signUpUser;
  SignUpCubit(this._signUpUser) : super(const SignUpState());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      authError: const AuthError(AuthErrorType.noAuthError),
      status: Formz.validate([
        username,
        state.email,
        state.password,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      authError: const AuthError(AuthErrorType.noAuthError),
      status: Formz.validate([
        state.username,
        email,
        state.password,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      authError: const AuthError(AuthErrorType.noAuthError),
      status: Formz.validate([
        state.username,
        state.email,
        password,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    Map<String, String> map = {
      "name": state.username.value,
      "email": state.email.value,
      "password": state.password.value,
    };

    final response = await _signUpUser(map);

    response.fold((authError) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        authError: authError,
      ));
    }, (success) {
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
    });
  }
}
