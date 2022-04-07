import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:dining_hall/data/models/order_model.dart';
import 'package:dining_hall/data/models/product_model.dart';
import 'package:dining_hall/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? userId;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final List<ProductModel>? favorites;
  final List<OrderModel>? currentOrders;
  final List<OrderModel>? orderHistory;

  const UserModel({
    this.userId,
    this.username,
    this.email,
    this.phoneNumber,
    this.favorites,
    this.currentOrders,
    this.orderHistory,
  }) : super(
          userId: userId,
          username: username,
          email: email,
          phoneNumber: phoneNumber,
          favorites: favorites,
          currentOrders: currentOrders,
          orderHistory: orderHistory,
        );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'favorites': favorites?.map((x) => x.toMap()).toList(),
      'currentOrders': currentOrders?.map((x) => x.toMap()).toList(),
      'orderHistory': orderHistory?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'] ?? "",
      favorites: List<ProductModel>.from(map['favorites']?.map((x) => ProductModel.fromMap(x))),
      currentOrders: List<OrderModel>.from(map['currentOrders']?.map((x) => OrderModel.fromMap(x))),
      orderHistory: List<OrderModel>.from(map['orderHistory']?.map((x) => OrderModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
