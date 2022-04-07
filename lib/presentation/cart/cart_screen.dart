import 'package:dining_hall/blocs/cart_bloc/cart_bloc.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';
import 'package:dining_hall/presentation/cart/cart_item_card.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartRepository _cartRepository;
  @override
  void initState() {
    context.read<CartBloc>().add(CartLoadEvent());
    _cartRepository = getItInstance<CartRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getProportionateScreenHeight(80)),
        child: AppBar(
          backgroundColor: kBackgroundColor100,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Center(
            child: Text(
              "Cart",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadSuccess) {
            if (state.items.length > 0) {
              return Container(
                width: getProportionateScreenWidth(180),
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(50)),
                ),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(50)),
                  splashColor: kPrimaryColor,
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteList.checkOut);
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
                            Icons.check_outlined,
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
                          "CHECKOUT",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
          }
          return Container();
        },
      ),
      body: Container(
        color: kBackgroundColor100,
        height: SizeConfig.screenHeight - getProportionateScreenHeight(167),
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoadSuccess) {
                final item = state.items;
                if (item.length == 0) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "Add some food to cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                // return Center(child: Text(state.items.toString()));
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "  (" +
                                    _cartRepository.itemCount.toString() +
                                    (_cartRepository.itemCount == 1
                                        ? "item)"
                                        : "items)"),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Text(
                            "Rs " + _cartRepository.totalAmount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return CartItemCard(item[index]);
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("Something went wrong!"),
              );
            },
          ),
        ),
      ),
    );
  }
}
