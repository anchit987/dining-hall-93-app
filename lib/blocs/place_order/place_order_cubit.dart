import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dining_hall/data/repositories/user_repository_impl.dart';
import 'package:dining_hall/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final UserRespository _userRepository;
  PlaceOrderCubit(this._userRepository) : super(PlaceOrderInitial());

  Future<void> placingOrder() async {
    print("COMING HERE PLACE ORDER CUBIT");
    emit(PlaceOrderInProgressState());
    final response = await _userRepository.addOrder();
    print(response);
    print("coming Here after");
    response.fold(
      (l) {
        emit(PlaceOrderErrorState());
      },
      (r) {
        emit(PlaceOrderSuccessState());
      },
    );
  }
}
