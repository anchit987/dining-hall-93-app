import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final String? paymentMode;
  final List<CartItem>? products;
  final num? price;

  const OrderEntity({
    this.orderId,
    this.paymentMode,
    this.products,
    this.price,
  });

  @override
  List<Object?> get props => [orderId, paymentMode, products, price];
}
