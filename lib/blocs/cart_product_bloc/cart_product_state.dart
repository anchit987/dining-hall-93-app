part of 'cart_product_bloc.dart';

abstract class CartProductState extends Equatable {
  const CartProductState();
  
  @override
  List<Object> get props => [];
}

class CartProuctLoadingState extends CartProductState {}

class CartProductQuantityChangeState extends CartProductState {
  final int quanity;

  const CartProductQuantityChangeState(this.quanity);

  @override
  List<Object> get props => [quanity];
}