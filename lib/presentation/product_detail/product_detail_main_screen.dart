import 'package:dining_hall/blocs/cart_bloc/cart_bloc.dart';
import 'package:dining_hall/blocs/cart_product_bloc/cart_product_bloc.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailMainScreen extends StatefulWidget {
  final ProductEntity? product;
  const ProductDetailMainScreen({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetailMainScreen> createState() =>
      _ProductDetailMainScreenState();
}

class _ProductDetailMainScreenState extends State<ProductDetailMainScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CartProductBloc>()
        .add(GetProductQuantityEvent((widget.product?.productId) ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String _id = (widget.product?.productId) ?? "";
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<CartProductBloc, CartProductState>(
        builder: (context, state) {
          if (state is CartProuctLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
          if (state is CartProductQuantityChangeState) {
            int quanity = state.quanity;
            return Container(
              width: getProportionateScreenWidth(180),
              height: getProportionateScreenHeight(60),
              decoration: BoxDecoration(
                color: kPrimaryColorOpacity90,
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(50)),
              ),
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(50)),
                splashColor: kPrimaryColor,
                onTap: () {
                  context.read<CartProductBloc>().add(
                      CartProductQuanityIncreaseEvent(
                          widget.product ?? ProductEntity()));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(6),
                    vertical: getProportionateScreenHeight(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: kPrimaryColor,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "ADD TO CART",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Text("Something Went Wrong!");
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(20),
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  // fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(10)),
                      child: Image.network(
                        widget.product?.imgLink ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(getProportionateScreenHeight(5)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              getProportionateScreenWidth(10))),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  widget.product?.name ?? "",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  children: [
                    Text(
                      "Rs ${widget.product?.price}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    Spacer(),
                    BlocBuilder<CartProductBloc, CartProductState>(
                      builder: (context, state) {
                        if (state is CartProuctLoadingState) {
                          return Container();
                        } else if (state is CartProductQuantityChangeState) {
                          int quanity = state.quanity;
                          if (quanity == 0) {
                            return Container();
                          }
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                child: IconButton(
                                  splashRadius: getProportionateScreenWidth(25),
                                  focusColor: kPrimaryColor,
                                  color: kPrimaryColor,
                                  hoverColor: kPrimaryColor,
                                  splashColor: kPrimaryColor,
                                  onPressed: () {
                                    //TODO
                                    context.read<CartProductBloc>().add(
                                        CartProductQuanityDecreaseEvent(
                                            widget.product ?? ProductEntity()));
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // _ProductQuanityText(),
                              Text(
                                quanity.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const SizedBox(width: 10),
                              CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                child: IconButton(
                                  splashRadius: getProportionateScreenWidth(25),
                                  splashColor: kPrimaryColor,
                                  onPressed: () {
                                    //TODO
                                    context.read<CartProductBloc>().add(
                                        CartProductQuanityIncreaseEvent(
                                            widget.product ?? ProductEntity()));
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Text("Something Went Wrong!");
                      },
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  widget.product?.description ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
