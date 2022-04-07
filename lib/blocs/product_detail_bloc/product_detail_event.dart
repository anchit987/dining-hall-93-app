part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class ProductDetailLoadEvent extends ProductDetailEvent {
  const ProductDetailLoadEvent();

  @override
  List<Object> get props => [];
}
