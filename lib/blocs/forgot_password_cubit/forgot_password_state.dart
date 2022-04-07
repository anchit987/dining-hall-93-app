part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final Email email;
  final AuthError authError;
  final FormzStatus status;

  const ForgotPasswordState({
    this.email = const Email.pure(),
    this.authError = const AuthError(AuthErrorType.noAuthError),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [email, authError, status];

  ForgotPasswordState copyWith({
    Email? email,
    AuthError? authError,
    FormzStatus? status,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      authError: authError ?? this.authError,
      status: status ?? this.status,
    );
  }
}
