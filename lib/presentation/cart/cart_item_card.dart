import 'package:dining_hall/blocs/cart_bloc/cart_bloc.dart';
import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCard extends StatelessWidget {
  final CartItem? item;
  const CartItemCard(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          height: getProportionateScreenHeight(110),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(20)),
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(
            // horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(7),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(20),
                ),
                child: Image.network(
                  item?.imgLink ?? "",
                  fit: BoxFit.cover,
                  height: getProportionateScreenHeight(110),
                  width: getProportionateScreenWidth(110),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth - getProportionateScreenWidth(180),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.name ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Spacer(),
                        // SizedBox(width: getProportionateScreenWidth(60)),
                        IconButton(
                          onPressed: () {
                            //TODo
                          },
                          icon: const Icon(
                            Icons.close,
                            color: kPrimaryColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(height:  getProportionateScreenHeight(12)),
                  Row(
                    children: [
                      Text(
                        "Rs " + (item?.price.toString() ?? ""),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(60),
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start ,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            splashColor: kPrimaryColor,
                            onTap: () {
                              //Todo
                            },
                            child: Container(
                              height: getProportionateScreenWidth(30),
                              width: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: kPrimaryColor,
                                    width: getProportionateScreenWidth(2),
                                  )),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.remove,
                                color: kPrimaryColor,
                                size: getProportionateScreenWidth(16),
                              ),
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(8)),
                          Text(
                            (item?.quantity.toString() ?? ""),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: getProportionateScreenWidth(8)),
                          InkWell(
                            splashColor: kPrimaryColor,
                            onTap: () {
                              //TODO
                            },
                            child: Container(
                              height: getProportionateScreenWidth(30),
                              width: getProportionateScreenWidth(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kPrimaryColor,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: getProportionateScreenWidth(16),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
              // Text(item?.quantity.toString() ?? "")
            ],
          ),
        );
      },
    );
  }
}
