part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final UserUid uid;

  const AuthUserChanged(this.uid);

  @override
  List<Object> get props => [uid];
}

class AuthLogoutRequest extends AuthEvent {}
