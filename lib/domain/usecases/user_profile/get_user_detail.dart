import 'package:dartz/dartz.dart';
import 'package:dining_hall/data/repositories/user_repository_impl.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dining_hall/domain/entities/no_params.dart';
import 'package:dining_hall/domain/entities/user_entity.dart';
import 'package:dining_hall/domain/repositories/user_repository.dart';
import 'package:dining_hall/domain/usecases/usecase.dart';

class GetUserDetail extends UseCase<UserEntity, NoParams> {
  final UserRespository _userRespository;

  GetUserDetail(this._userRespository);

  @override
  Future<Either<AppError, UserEntity>> call(NoParams params) async {
    final response = await _userRespository.getUserDetail();
    return response;
  }
}
