import 'package:dining_hall/domain/entities/cart_item.dart';

abstract class CartRepository {
  int get itemCount;

  num get totalAmount;

  List<CartItem> getAllItem();

  CartItem addItem({
    String? productId,
    String? name,
    String? imgLink,
    num? price,
  });

  int getQuantity(String id);

  void removeItem({String? productId});

  void removeSingleItem({String? productId});

  void clearCart();
}
