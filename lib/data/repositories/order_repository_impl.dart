import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dining_hall/data/models/order_model.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';
import 'package:dining_hall/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirebaseFirestore _firestore; 
  List<OrderEntity> _orders = [];

  OrderRepositoryImpl(this._firestore);

  @override
  Future<Either<AppError, Unit>> placeOrder({OrderEntity? order}) {
    // TODO: implement placeOrder
    throw UnimplementedError();
  }

}
