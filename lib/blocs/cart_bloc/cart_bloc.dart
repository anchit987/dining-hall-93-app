import 'package:bloc/bloc.dart';
import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';
import 'package:dining_hall/domain/usecases/cart/add_item_to_cart.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  CartBloc(this._cartRepository, this._addItemToCart) : super(CartLoadInProgress()) {
    on<CartLoadEvent>((event, emit) {
      emit(CartLoadInProgress());
      final items = _cartRepository.getAllItem();
      emit(CartLoadSuccess(items));
    });
    on<CartItemAddEvent>((event, emit) {
      print("EMIT CARTITEMADDEDSTATe");
      final product = event.product;
      final cartItem = _addItemToCart(
        productId: product.productId,
        name: product.name,
        imgLink: product.imgLink,
        price: product.price,
      );
      print("EMIT CARTITEMADDEDSTATe");
      emit(CartItemAddedState(cartItem));
    });
  }

  final AddItemToCart _addItemToCart;
}
