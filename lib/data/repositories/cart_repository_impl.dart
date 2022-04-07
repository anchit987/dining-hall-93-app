import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  Map<String, CartItem> _items = {};

  @override
  int get itemCount {
    return _items.length;
  }

  @override
  num get totalAmount {
    num total = 0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price ?? 0) * (cartItem.quantity ?? 0);
    });
    return total;
  }

  @override
  CartItem addItem({
    String? productId,
    String? name,
    String? imgLink,
    num? price,
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId ?? "",
        (existingCartItem) => CartItem(
          productId: existingCartItem.productId,
          name: existingCartItem.name,
          imgLink: existingCartItem.imgLink,
          price: existingCartItem.price,
          quantity: (existingCartItem.quantity ?? 0) + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId ?? "",
        () => CartItem(
          productId: productId,
          name: name,
          imgLink: imgLink,
          price: price,
          quantity: 1,
        ),
      );
    }
    print(_items.toString());
    return _items[productId] ?? const CartItem();
  }

  @override
  void removeItem({String? productId}) {
    _items.remove(productId ?? "");
  }

  @override
  void removeSingleItem({String? productId}) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if ((_items[productId]?.quantity ?? 0) > 1) {
      _items.update(
        productId ?? "",
        (existingCartItem) => CartItem(
          productId: existingCartItem.productId,
          name: existingCartItem.name,
          imgLink: existingCartItem.imgLink,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity! - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
  }

  @override
  void clearCart() {
    _items = {};
  }

  @override
  int getQuantity(String id) {
    if (_items.containsKey(id)) {
      return _items[id]?.quantity ?? 0;
    }
    return 0;
  }

  @override
  List<CartItem> getAllItem() {
    List<CartItem> cartItem = [];
    _items.forEach((key, value) {
      cartItem.add(value);
    });
    print(cartItem);
    return cartItem;
  }
}
