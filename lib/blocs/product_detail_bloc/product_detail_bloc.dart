import 'package:bloc/bloc.dart';
import 'package:dining_hall/domain/entities/no_params.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/domain/usecases/products/get_all_products.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetAllProducts _getAllProducts;

  ProductDetailBloc(GetAllProducts getAllProducts)
      : _getAllProducts = getAllProducts,
        super(ProductDetailInitial()) {
    on<ProductDetailLoadEvent>((event, emit) async {
      final response = await _getAllProducts.call(NoParams());
      print(response.toString());
      emit(response.fold(
          (l) => ProductDetailError(), (r) => ProductDetailLoadedState(r)));
    });
  }
}
