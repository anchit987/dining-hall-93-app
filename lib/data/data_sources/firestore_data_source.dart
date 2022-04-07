import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dining_hall/data/models/product_model.dart';
import 'package:dining_hall/data/models/user_model.dart';

import 'package:dining_hall/domain/entities/errors/app_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreDataSource {
  Future<void> addUsertoFirestore();
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirestoreDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<void> addUsertoFirestore() async {
    final currentUser = _firebaseAuth.currentUser;
    final user = UserModel(
      userId: currentUser?.uid,
      email: currentUser?.email,
      username: currentUser?.displayName,
      currentOrders: [],
      favorites: [],
      orderHistory: [],
      phoneNumber: "",
    ).toMap();
    // print("entry started YYYYYYYYYYYYYYYYYYYYYYYY");
    // await _firestore.collection("products").doc("thalis").set({
    //   "thalis": [
    //     ProductModel(
    //       productId: "regular-thali",
    //       name: "Regular Thali",
    //       description: "4 Plain Roti, 2 Vegetable, Rice, Dal, Salad.",
    //       todayMenu: "4 Plain Roti, 2 Vegetable, Rice, Dal, Salad.",
    //       imgLink: "regular-thali.jpg",
    //       price: 50,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "special-thali",
    //       name: "Special Thali",
    //       description:
    //           "4 Butter Chappati, 3 Vegetable, rice, pulse, dessert, salad.",
    //       todayMenu:
    //           "4 Butter Chappati, 3 Vegetable, rice, pulse, dessert, salad.",
    //       imgLink: "special-thali.jpg",
    //       price: 70,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "dal-bati",
    //       name: "Dal Bati",
    //       description:
    //           "2 Bati, Dal, Rice, Salad, Laddu, Aloo Sabji.",
    //       todayMenu:
    //           "2 Bati, Dal, Rice, Salad, Laddu, Aloo Sabji.",
    //       imgLink: "dal-bati.jpeg",
    //       price: 90,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "aalo-partha",
    //       name: "Aalo Partha",
    //       description:
    //           "Aalo Partha, Green Chutni, Tomato Sauce, salad",
    //       todayMenu:
    //           "Aalo Partha, Green Chutni, Tomato Sauce, salad",
    //       imgLink: "aalo-partha.jpeg",
    //       price: 50,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "cholle-kulche",
    //       name: "Cholle Kulche",
    //       description:
    //           "Cholle, 2 Kulche, salad",
    //       todayMenu:
    //           "Cholle, 2 Kulche, salad",
    //       imgLink: "cholle-kulche.jpeg",
    //       price: 90,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "pav-bhajji",
    //       name: "Pav Bhajji",
    //       description:
    //           "2 Pav, Bhajji, salad",
    //       todayMenu:
    //           "2 Pav, Bhajji, salad",
    //       imgLink: "pav-bhajji.jpeg",
    //       price: 80,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "dosa",
    //       name: "Dosa",
    //       description:
    //           "Dosa, Sambar, Chutney",
    //       todayMenu:
    //           "Dosa, Sambar, Chutney",
    //       imgLink: "dosa.jpg",
    //       price: 70,
    //     ).toMap(),
    //     ProductModel(
    //       productId: "eddli",
    //       name: "Eddli Sambhar",
    //       description:
    //           "2 Eddli, Sambhar, Chutney",
    //       todayMenu:
    //           "2 Eddli, Sambhar, Chutney",
    //       imgLink: "eddli.jpeg",
    //       price: 50,
    //     ).toMap(),
    //   ]
    // });

    await _firestore.collection("users").doc(currentUser?.uid).set(user);
  }
}
