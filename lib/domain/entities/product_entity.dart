import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final String? name;
  final String? description;
  final String? todayMenu;
  String? imgLink;
  final num? price;

  ProductEntity({
    @required this.productId,
    @required this.name,
    @required this.description,
    @required this.todayMenu,
    @required this.imgLink,
    @required this.price,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        description,
        todayMenu,
        imgLink,
        price,
      ];

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'todayMenu': todayMenu,
      'imgLink': imgLink,
      'price': price,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      productId: map['productId'] != null ? map['productId'] : null,
      name: map['name'] != null ? map['name'] : null,
      description: map['description'] != null ? map['description'] : null,
      todayMenu: map['todayMenu'] != null ? map['todayMenu'] : null,
      imgLink: map['imgLink'] != null ? map['imgLink'] : null,
      price: map['price'] != null ? map['price'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromJson(String source) => ProductEntity.fromMap(json.decode(source));
}
