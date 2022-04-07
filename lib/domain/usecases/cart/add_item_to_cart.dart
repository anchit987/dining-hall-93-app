import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';

class AddItemToCart {
  final CartRepository _cartRepository;

  AddItemToCart(this._cartRepository);

  CartItem call({
    String? productId,
    String? name,
    String? imgLink,
    num? price,
  }) {
    final CartItem cartItem = _cartRepository.addItem(
      productId: productId,
      name: name,
      imgLink: imgLink,
      price: price,
    );
    return cartItem;
  }
}
