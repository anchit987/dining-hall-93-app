import 'package:dartz/dartz.dart';
import 'package:dining_hall/domain/entities/cart_item.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderEntity _orderEntity;
  const OrderCardWidget(this._orderEntity, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      // height: getProportionateScreenHeight(200),
      width: SizeConfig.screenWidth - getProportionateScreenWidth(40),
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenHeight(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: "Order Id: ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: " #" + _orderEntity.orderId.toString(),
                      style: TextStyle(
                        color: kPrimaryColor,
                      ))
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                Text(
                  "Payment: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.monetization_on,
                  color: kPrimaryColor,
                ),
                // SizedBox(
                //   width: getProportionateScreenWidth(2),
                // ),
                Text(
                  "Cash On Delivery",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              children: [
                Text(
                  "Total Amount: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Rs " + _orderEntity.price.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _orderEntity.products?.length,
              itemBuilder: (context, index) {
                final product = _orderEntity.products?[index] ?? CartItem();
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
                  child: ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(product.imgLink ?? "")),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            // color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Text(
                          "X" + product.quantity.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
