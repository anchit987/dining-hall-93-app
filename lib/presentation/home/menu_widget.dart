import 'package:dining_hall/blocs/product_detail_bloc/product_detail_bloc.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/home/product_card_widget.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailInitial) {
          return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor));
        } else if (state is ProductDetailError) {
          return const Center(
            child: Text("ERROR"),
          );
        } else if (state is ProductDetailLoadedState) {
          return Container(
            // height: getProportionateScreenWidth(470),
            width: double.infinity,

            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ProductCardWidget(
                      product: state.products[index],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    )
                  ],
                );
              },
            ),
          );
        }
        return const Center(
          child: Text("SOMETHING WENT WRONG"),
        );
      },
    );
  }
}
