import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dining_hall/data/models/product_model.dart';
import 'package:dining_hall/data/models/product_result_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  ProductRemoteDataSourceImpl(this._firestore, this._firebaseStorage);

  Future<String> getDownloadUrl(String? img) async {
    final ref = _firebaseStorage.ref(img);
    final downloadLink = await ref.getDownloadURL();
    print("DOWNLOAD LINK:::::::::::::::");

    print(downloadLink);
    return downloadLink;
  }

  Future<void> updateDownloadLinkForProduct(List<ProductModel> products) async {
    await Future.wait(products.map((element) async {
      element.imgLink = await getDownloadUrl(element.imgLink);
    }));
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    print("INSIDE PRODUCT REMOTE DATA SOURCES: ");
    final response =
        await _firestore.collection("products").doc("thalis").get();
    dynamic data = response.data();
    print("INSIDE PRODUCT REMOTE DATA SOURCES");
    final List<ProductModel> products =
        ProductResultModel.fromMap(data ?? {}).products;
        print(products.toString());
    await updateDownloadLinkForProduct(products);
    print("NEW PRODUCTS " + products.toString());
    return products;
  }
}
