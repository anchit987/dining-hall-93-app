import 'package:dining_hall/blocs/cart_bloc/cart_bloc.dart';
import 'package:dining_hall/blocs/cart_product_bloc/cart_product_bloc.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/presentation/product_detail/product_detail_main_screen.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity? product;
  const ProductDetailScreen({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => getItInstance<CartProductBloc>(),
      child: ProductDetailMainScreen(product: product),
    );
  }
}
