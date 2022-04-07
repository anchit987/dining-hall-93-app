import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dining_hall/blocs/place_order/place_order_cubit.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';
import 'package:dining_hall/domain/repositories/user_repository.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/constants/route_constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final CartRepository _cartRepository;
  @override
  void initState() {
    super.initState();
    _cartRepository = getItInstance<CartRepository>();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => getItInstance<PlaceOrderCubit>(),
      child: BlocListener<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) {
          if (state is PlaceOrderSuccessState) {
            AwesomeDialog(
                context: context,
                animType: AnimType.LEFTSLIDE,
                headerAnimationLoop: false,
                dialogType: DialogType.SUCCES,
                showCloseIcon: true,
                title: 'Success',
                desc: 'Order Placed Successfully.',
                btnOkOnPress: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteList.home, (route) => false);
                },
                btnOkIcon: Icons.check_circle,
                onDissmissCallback: (type) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteList.home, (route) => false);
                })
              ..show();
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(getProportionateScreenHeight(80)),
            child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kBackgroundColor100,
              foregroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text(
                "Checkout",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
            builder: (context, state) {
              if (state is PlaceOrderInitial) {
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
                      context.read<PlaceOrderCubit>().placingOrder();
                      // Navigator.of(context).pushNamed(RouteList.checkOut);
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
                              Icons.payment,
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
                            "Place Order",
                            softWrap: true,
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
              } else if (state is PlaceOrderInProgressState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              } else if (state is PlaceOrderSuccessState) {
                return Center(
                  child: Text("SUCCSS!!"),
                );
              }
              return Center(
                child: Text("SOMETHING WENT WRONG!!"),
              );
            },
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Container(
              height:
                  SizeConfig.screenHeight - getProportionateScreenHeight(107),
              width: SizeConfig.screenWidth,
              color: kBackgroundColor100,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "   Payment",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                    SizedBox(height: getProportionateScreenHeight(35)),
                    Text(
                      "Payment method",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          RadioListTile(
                            title: Text(
                              "Card",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            value: 1,
                            groupValue: 3,
                            onChanged: (value) {},
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          RadioListTile(
                            title: Text(
                              "UPI",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            value: 2,
                            groupValue: 3,
                            onChanged: (value) {},
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          RadioListTile(
                            title: Text(
                              "Cash",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            value: 3,
                            groupValue: 3,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Rs " + _cartRepository.totalAmount.toString() + ".00    ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
