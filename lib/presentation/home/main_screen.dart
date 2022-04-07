import 'package:dining_hall/presentation/home/menu_widget.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.grey.shade100,
      height: SizeConfig.screenHeight - getProportionateScreenHeight(170),
      width: SizeConfig.screenWidth,
      // color: Colors.white,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "What would you like to order ?",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const _SearchInputField(),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  const MenuWidget(),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchInputField extends StatelessWidget {
  const _SearchInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: TextField(
            // autofocus: false,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
              hintText: 'Find for food',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.sort,
            color: Colors.grey,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
