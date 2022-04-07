part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Username username;
  final Email email;
  final Password password;
  final FormzStatus status;
  final AuthError authError;

  const SignUpState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.authError = const AuthError(AuthErrorType.noAuthError),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [username, email, password, authError, status];

  SignUpState copyWith({
    Username? username,
    Email? email,
    Password? password,
    AuthError? authError,
    FormzStatus? status,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      authError: authError ?? this.authError,
      status: status ?? this.status,
    );
  }
}
