part of 'place_order_cubit.dart';

abstract class PlaceOrderState extends Equatable {
  const PlaceOrderState();

  @override
  List<Object> get props => [];
}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderInProgressState extends PlaceOrderState {}

class PlaceOrderSuccessState extends PlaceOrderState {}

class PlaceOrderErrorState extends PlaceOrderState{}
