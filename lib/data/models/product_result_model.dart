import 'dart:convert';

import 'package:dining_hall/data/models/product_model.dart';

class ProductResultModel {
  List<ProductModel> products;

  ProductResultModel(this.products);

  Map<String, dynamic> toMap() {
    return {
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductResultModel.fromMap(Map<String, dynamic> map) {
    return ProductResultModel(
      List<ProductModel>.from(
        map['thalis'].map(
          (x) => ProductModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductResultModel.fromJson(String source) =>
      ProductResultModel.fromMap(json.decode(source));
}
