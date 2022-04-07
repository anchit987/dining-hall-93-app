import 'package:dartz/dartz.dart';
import 'auth_usecase.dart';

import '../../entities/errors/auth_error.dart';
import '../../repositories/auth_repository.dart';

class SignInUser extends AuthUsecase<Unit, Map<String, String>> {
  final AuthRepository _authRepository;

  SignInUser(this._authRepository);

  @override
  Future<Either<AuthError, Unit>> call(Map<String, String> params) async {
    final response = await _authRepository.signInWithEmailAndPassword(
      email: params["email"],
      password: params["password"],
    );
    return response;
  }
}
