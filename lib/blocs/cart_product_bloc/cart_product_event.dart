part of 'cart_product_bloc.dart';

abstract class CartProductEvent extends Equatable {
  const CartProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductQuantityEvent extends CartProductEvent {
  final String id;

  const GetProductQuantityEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CartProductQuanityIncreaseEvent extends CartProductEvent {
  final ProductEntity product;
  const CartProductQuanityIncreaseEvent(this.product);
  @override
  List<Object> get props => [product];
}

class CartProductQuanityDecreaseEvent extends CartProductEvent {
  final ProductEntity product;
  const CartProductQuanityDecreaseEvent(this.product);
  @override
  List<Object> get props => [product];
}
