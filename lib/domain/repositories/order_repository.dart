import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<AppError, Unit>> placeOrder({OrderEntity order});
}
