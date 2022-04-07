import 'package:dining_hall/domain/entities/product_entity.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductEntity? product;

  const ProductCardWidget({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).pushNamed(
          RouteList.productDetail,
          arguments: product,
        );
      },
      child: Container(
        width: getProportionateScreenWidth(330),
        height: getProportionateScreenHeight(280),
        // padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(16),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getProportionateScreenWidth(16)),
                topRight: Radius.circular(getProportionateScreenWidth(16)),
              ),
              child: Image.network(
                product?.imgLink ?? "",
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(190),
                width: getProportionateScreenWidth(330),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                getProportionateScreenWidth(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product?.name ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.teal,
                        size: 18,
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(6),
                  ),
                  Container(
                    width: getProportionateScreenHeight(300) -
                        getProportionateScreenWidth(10),
                    child: Wrap(
                      children: [
                        Text(
                          product?.description ?? "",
                          softWrap: true,
                          style: const TextStyle(overflow: TextOverflow.fade),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
