import 'package:bloc/bloc.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';
import 'package:equatable/equatable.dart';

part 'cart_product_event.dart';
part 'cart_product_state.dart';

class CartProductBloc extends Bloc<CartProductEvent, CartProductState> {
  final CartRepository _cartRepository;
  CartProductBloc(this._cartRepository) : super(CartProuctLoadingState()) {
    on<GetProductQuantityEvent>((event, emit) {
      emit(CartProuctLoadingState());
      final quanity = _cartRepository.getQuantity(event.id);
      emit(CartProductQuantityChangeState(quanity));
    });
    on<CartProductQuanityIncreaseEvent>((event, emit) {
      emit(CartProuctLoadingState());
      _cartRepository.addItem(
        productId: event.product.productId,
        name: event.product.name,
        imgLink: event.product.imgLink,
        price: event.product.price,
      );
      int quanity = _cartRepository.getQuantity(event.product.productId ?? "");
      emit(CartProductQuantityChangeState(quanity));
    });
    on<CartProductQuanityDecreaseEvent>((event, emit) {
      emit(CartProuctLoadingState());
      _cartRepository.removeSingleItem(
          productId: event.product.productId ?? "");
      int quanity = _cartRepository.getQuantity(event.product.productId ?? "");
      emit(CartProductQuantityChangeState(quanity));
    });
  }
}
