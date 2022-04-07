import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';
import 'package:dining_hall/domain/entities/user_entity.dart';

abstract class UserRespository {
  Future<Either<AppError, UserEntity>> getUserDetail();
  Future<Either<AppError, Unit>> addToCart(String productId);
  Future<Either<AppError, Unit>> addItemToFav(String productId);
  Future<Either<AppError, Unit>> addOrder();
  List<OrderEntity> getAllOrder();
}
