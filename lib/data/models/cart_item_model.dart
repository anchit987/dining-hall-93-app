import 'dart:convert';

import 'package:dining_hall/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  final String? productId;
  final String? name;
  final String? imgLink;
  final int? quantity;
  final num? price;

  CartItemModel({
    this.productId,
    this.name,
    this.imgLink,
    this.quantity,
    this.price,
  }) : super(
          productId: productId,
          name: name,
          imgLink: imgLink,
          quantity: quantity,
          price: price,
        );

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'imgLink': imgLink,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'] != null ? map['productId'] : null,
      name: map['name'] != null ? map['name'] : null,
      imgLink: map['imgLink'] != null ? map['imgLink'] : null,
      quantity: map['quantity'] != null ? map['quantity'] : null,
      price: map['price'] != null ? map['price'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));
}
