import 'package:dining_hall/data/data_sources/firestore_data_source.dart';
import '../../domain/entities/user_uid.dart';
import '../../domain/entities/errors/auth_error.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
class FirebaseAuthImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirestoreDataSource _firebaseDataSources;

  //? add user to firestore
  FirebaseAuthImpl(this._firebaseAuth, this._firebaseDataSources);

  @override
  Stream<UserUid> get uid {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserUid.empty : firebaseUser.toUser;
    });
  }

  @override
  Future<Either<AuthError, Unit>> registerWithEmailAndPassword(
      {String? name, String? email, String? password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      //* On sign up new user will be added to the firestore
      await _firebaseAuth.currentUser?.updateDisplayName(name);
      _firebaseDataSources.addUsertoFirestore();

      //* ON SUCCESS
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(const AuthError(AuthErrorType.emailAlreadyInUse));
      }
    }
    return left(const AuthError(AuthErrorType.unknownError));
  }

  @override
  Future<Either<AuthError, Unit>> signInWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        return left(const AuthError(AuthErrorType.emailOrPasswordNotMatch));
      } else if (e.code == "user-disabled") {
        return left(const AuthError(AuthErrorType.userDisabled));
      }
    }
    return left(const AuthError(AuthErrorType.unknownError));
  }

  @override
  Future<Either<AuthError, Unit>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(unit);
    } catch (e) {
      return left(const AuthError(AuthErrorType.unknownError));
    }
  }

  @override
  Future<Either<AuthError, Unit>> forgotPassword({String? email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email ?? "");
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return left(const AuthError(AuthErrorType.userNotFound));
      } else {
        return left(const AuthError(AuthErrorType.cantResetPassword));
      }
    }
  }
}

extension on firebase_auth.User {
  UserUid get toUser {
    return UserUid(uid: uid);
  }
}
