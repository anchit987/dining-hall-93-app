import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dining_hall/domain/entities/no_params.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/domain/repositories/product_repository.dart';
import 'package:dining_hall/domain/usecases/usecase.dart';

class GetAllProducts extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRespository _productRespository;

  GetAllProducts(this._productRespository);

  @override
  Future<Either<AppError, List<ProductEntity>>> call(NoParams params) async {
    final response = await _productRespository.getAllProducts();
    return response;
  }
}
