import 'package:dartz/dartz.dart';
import '../entities/errors/auth_error.dart';
import '../entities/user_uid.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthRepository {
  Stream<UserUid> get uid;
  Future<Either<AuthError, Unit>>  registerWithEmailAndPassword({
    @required String? name,
    @required String? email,
    @required String? password,
  });

  Future<Either<AuthError, Unit>> signInWithEmailAndPassword({
    @required String? email,
    @required String? password,
  });

  Future<Either<AuthError, Unit>> signOut();

  Future<Either<AuthError, Unit>> forgotPassword({@required String? email});
}