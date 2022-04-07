part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartLoadInProgress extends CartState {}

class CartLoadSuccess extends CartState {
  final List<CartItem> items;

  const CartLoadSuccess(this.items);

  @override
  List<Object> get props => [items];
}

class CartItemAddedState extends CartState {
  final CartItem cartItem;

  const CartItemAddedState(this.cartItem);

  @override
  List<Object> get props => [cartItem];
}

class CartLoadErrorState extends CartState {}


