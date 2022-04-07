part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailError extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final List<ProductEntity> products;

  const ProductDetailLoadedState(this.products);

  @override
  List<Object> get props => [products];
}
