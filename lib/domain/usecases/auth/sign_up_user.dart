import 'package:dartz/dartz.dart';
import '../../entities/errors/auth_error.dart';
import '../../repositories/auth_repository.dart';
import 'auth_usecase.dart';

class SignUpUser extends AuthUsecase<Unit, Map<String, String>> {
  final AuthRepository _authRepository;

  SignUpUser(this._authRepository);

  @override
  Future<Either<AuthError, Unit>> call(Map<String, String> params) async {
    final response = await _authRepository.registerWithEmailAndPassword(
      name: params["name"],
      email: params["email"],
      password: params["password"],
    );
    return response;
  }
}
