import 'dart:convert';

import 'package:dining_hall/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final String? productId;
  final String? name;
  final String? description;
  final String? todayMenu;
  String? imgLink;
  final num? price;
  ProductModel(
      {this.productId,
      this.name,
      this.description,
      this.todayMenu,
      this.imgLink,
      this.price})
      : super(
          productId: productId,
          name: name,
          description: description,
          todayMenu: todayMenu,
          imgLink: imgLink,
          price: price,
        );

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

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] != null ? map['productId'] : null,
      name: map['name'] != null ? map['name'] : null,
      description: map['description'] != null ? map['description'] : null,
      todayMenu: map['todayMenu'] != null ? map['todayMenu'] : null,
      imgLink: map['imgLink'] != null ? map['imgLink'] : null,
      price: map['price'] != null ? map['price'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
