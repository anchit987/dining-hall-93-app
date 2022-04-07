import 'package:bloc/bloc.dart';
import 'package:dining_hall/domain/entities/errors/auth_error.dart';
import 'package:dining_hall/domain/entities/input_entities/email.dart';
import 'package:dining_hall/domain/usecases/auth/forgot_password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPassword _forgotPassword;
  ForgotPasswordCubit(this._forgotPassword)
      : super(const ForgotPasswordState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
      ]),
    ));
  }

  Future<void> sendResetPasswordEmail() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    String email = state.email.value;

    final response = await _forgotPassword(email);

    response.fold((authError) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        authError: authError,
      ));
    }, (_) {
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    });
  }
}
