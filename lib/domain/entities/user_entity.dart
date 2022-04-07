import 'package:dining_hall/domain/entities/order_entity.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final List<ProductEntity>? favorites;
  final List<OrderEntity>? currentOrders;
  final List<OrderEntity>? orderHistory;

  const UserEntity({
    @required this.userId,
    @required this.username,
    @required this.email,
    @required this.phoneNumber,
    @required this.favorites,
    @required this.currentOrders,
    @required this.orderHistory,
  });
  @override
  List<Object?> get props => [
        userId,
        username,
        email,
        phoneNumber,
        favorites,
        currentOrders,
        orderHistory,
      ];
}
