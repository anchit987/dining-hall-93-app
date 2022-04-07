import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dining_hall/data/models/cart_item_model.dart';
import 'package:dining_hall/data/models/order_model.dart';
import 'package:dining_hall/data/models/user_model.dart';
import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/domain/entities/user_entity.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';
import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';
import 'package:dining_hall/domain/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl extends UserRespository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final CartRepository _cartRepository;

  List<OrderEntity> _orders = [];

  UserRepositoryImpl(this._firebaseAuth, this._firestore, this._cartRepository);

  @override
  Future<Either<AppError, Unit>> addItemToFav(String productId) {
    // TODO: implement addItemToFav
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, Unit>> addOrder() async {
    // final orderId = DateTime.now().toString() +
    //     " " +
    //     (_firebaseAuth.currentUser?.email ?? "");
    final orderId = Random().nextInt(9999999 - 999999).toString();
    final _orderMap = OrderModel(
      orderId: orderId,
      paymentMode: "cash",
      price: _cartRepository.totalAmount,
      products: _cartRepository
          .getAllItem()
          .map((e) => CartItemModel(
                productId: e.productId,
                name: e.name,
                imgLink: e.imgLink,
                price: e.price,
                quantity: e.quantity,
              ))
          .toList(),
    ).toMap();
    print(_orderMap);
    print("USER REPOSITORY");
    try {
      await _firestore.collection("orders").doc(((_firebaseAuth.currentUser?.email ?? "") + "-" + orderId)).set(_orderMap);
      await _firestore
          .collection("users")
          .doc(_firebaseAuth.currentUser?.uid)
          .update({
        "currentOrders": FieldValue.arrayUnion([_orderMap])
      });
      _orders.add(OrderEntity(
          orderId: orderId,
          paymentMode: "cash",
          products: _cartRepository.getAllItem(),
          price: _cartRepository.totalAmount));
      print("IIIIIIIIIIIIIIIIIIIIII");
      _cartRepository.clearCart();
      print(_orders);
      return right(unit);
    } catch (e) {
      print(e.toString());
      return left(const AppError(AppErrorType.noError));
    }
  }

  @override
  Future<Either<AppError, Unit>> addToCart(String productId) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  List<CartItem> getCartEntity(List<CartItemModel>? model) {
    List<CartItem> allItem = [];
    model?.forEach((element) {
      allItem.add(CartItem(
        productId: element.productId,
        imgLink: element.imgLink,
        name: element.name,
        price: element.price,
        quantity: element.quantity,
      ));
    });
    return allItem;
  }

  @override
  Future<Either<AppError, UserEntity>> getUserDetail() async {
    try {
      dynamic id = _firebaseAuth.currentUser?.uid;
      final response = await _firestore.collection("users").doc(id).get();
      final data = response.data();
      final user = UserModel.fromMap(data ?? {});
      if (_orders.isEmpty) {
        user.currentOrders?.forEach((element) {
          _orders.add(
            OrderEntity(
              orderId: element.orderId,
              paymentMode: element.paymentMode,
              price: element.price,
              products: getCartEntity(element.products),
            ),
          );
        });
      }
      print("getUserDetail ORDER:");
      print(_orders);
      return right(user);
    } catch (e) {
      //TODO: IMPLEMENT
      return left(const AppError(AppErrorType.noError));
    }
  }

  @override
  List<OrderEntity> getAllOrder() {
    List<OrderEntity> cartItem = [];
    _orders.forEach((element) {
      cartItem.add(element);
    });
    // print(cartItem);
    return cartItem;
  }
}
