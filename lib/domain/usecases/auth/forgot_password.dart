import 'package:dartz/dartz.dart';
import '../../entities/errors/auth_error.dart';
import '../../repositories/auth_repository.dart';
import 'auth_usecase.dart';

class ForgotPassword extends AuthUsecase<Unit, String> {
  final AuthRepository _authRepository;

  ForgotPassword(this._authRepository);

  @override
  Future<Either<AuthError, Unit>> call(String params) async {
    final response = await _authRepository.forgotPassword(email: params);
    return response;
  }
}
