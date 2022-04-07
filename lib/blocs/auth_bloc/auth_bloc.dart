import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user_uid.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<UserUid>? _uidSubscription;
  AuthBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    _uidSubscription =
        _authRepository.uid.listen((uid) => add(AuthUserChanged(uid)));

    on<AuthUserChanged>((event, emit) {
      if(event.uid != UserUid.empty) {
        emit(AuthState.authenticated(event.uid));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });

    on<AuthLogoutRequest>((event, emit) {
      _authRepository.signOut();
      emit(const AuthState.unauthenticated());
    });
  }

  @override
  Future<void> close() {
    _uidSubscription?.cancel();
    return super.close();
  }
}
