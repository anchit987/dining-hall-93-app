part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState extends Equatable {
  final AuthStatus status;
  final UserUid uid;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.uid = UserUid.empty,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(UserUid uid)
      : this._(status: AuthStatus.authenticated, uid: uid);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, uid];
}
