import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dining_hall/data/data_sources/product_remote_data_source.dart';
import 'package:dining_hall/data/models/product_model.dart';

import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRespository {
  final ProductRemoteDataSource _productRemoteDataSouce;
  ProductRepositoryImpl(this._productRemoteDataSouce);

  @override
  Future<Either<AppError, List<ProductEntity>>> getAllProducts() async {
    try {
      final products = await _productRemoteDataSouce.getAllProducts();
      return right(products);
    } catch (e) {
      //TODO: IMPLEMENT
      print("ERROR" + e.toString());
      return left(const AppError(AppErrorType.noError));
    }
  }
}
