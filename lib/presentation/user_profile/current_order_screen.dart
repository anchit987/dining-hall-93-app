import 'package:dining_hall/data/repositories/user_repository_impl.dart';
import 'package:dining_hall/di/get_it.dart';
import 'package:dining_hall/domain/entities/order_entity.dart';
import 'package:dining_hall/domain/repositories/user_repository.dart';
import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:dining_hall/presentation/user_profile/order_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrentOrderScreen extends StatefulWidget {
  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  late final _userRepository;
  late final List<OrderEntity> orders;
  @override
  void initState() {
    super.initState();
    _userRepository = getItInstance<UserRespository>();
    orders = _userRepository.getAllOrder();
    print(orders.toString());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
            "Current Orders",
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight - getProportionateScreenHeight(107),
        width: SizeConfig.screenWidth,
        color: kBackgroundColor100,
        child: orders.length == 0
            ? Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.food_bank,
                    size: 100,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "No Current Orders",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: ListView.separated(
                  separatorBuilder: (_, index) => SizedBox(
                    height: 15,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return OrderCardWidget(orders[index]);
                  },
                ),
              ),
      ),
    );
  }
}
