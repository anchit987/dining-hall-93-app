import 'package:bloc/bloc.dart';
import '../../domain/entities/errors/auth_error.dart';
import '../../domain/entities/input_entities/email.dart';
import '../../domain/entities/input_entities/password.dart';
import '../../domain/usecases/auth/sign_in_user.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUser _signInUser;
  SignInCubit(this._signInUser) : super(const SignInState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      authError: const AuthError(AuthErrorType.noAuthError),
      status: Formz.validate([
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
        state.email,
        password,
      ]),
    ));
  }

  Future<void> signInFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    Map<String, String> map = {
      "email": state.email.value,
      "password": state.password.value,
    };

    final response = await _signInUser(map);

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
