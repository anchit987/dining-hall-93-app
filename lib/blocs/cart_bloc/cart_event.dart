part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadEvent extends CartEvent {}

class CartItemAddEvent extends CartEvent {
  final ProductEntity product;

  const CartItemAddEvent(this.product);

  @override
  List<Object> get props => [product];
}

class CartItemDeleteEvent extends CartEvent {
  final CartItem cartItem;

  const CartItemDeleteEvent(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartClearEvent extends CartEvent {}
