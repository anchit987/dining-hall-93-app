import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';

abstract class ProductRespository {
  Future<Either<AppError, List<ProductEntity>>> getAllProducts();

}
