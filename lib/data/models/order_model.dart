import 'dart:convert';

import 'package:dining_hall/data/models/cart_item_model.dart';
import 'package:dining_hall/data/models/product_model.dart';
import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  final String? orderId;
  final String? paymentMode;
  final List<CartItemModel>? products;
  final num? price;

  const OrderModel({
    this.orderId,
    this.paymentMode,
    this.products,
    this.price,
  }) : super(
          orderId: orderId,
          paymentMode: paymentMode,
          products: products,
          price: price,
        );

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'paymentMode': paymentMode,
      'products': products?.map((x) => x.toMap()).toList(),
      'price': price,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] != null ? map['orderId'] : null,
      paymentMode: map['paymentMode'] != null ? map['paymentMode'] : null,
      products: map['products'] != null
          ? List<CartItemModel>.from(
              map['products']?.map((x) => CartItemModel.fromMap(x)))
          : null,
      price: map['price'] != null ? map['price'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
