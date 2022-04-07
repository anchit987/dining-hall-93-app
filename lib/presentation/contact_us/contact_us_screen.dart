import 'package:dining_hall/presentation/constants/constants.dart';
import 'package:dining_hall/presentation/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
            "Contact Us",
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: kBackgroundColor100,
          height: SizeConfig.screenHeight - getProportionateScreenHeight(107),
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(20),
          ),
          child: Column(
            children: [
              // Icon(Icons.contactU)

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Subject',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your subject';
                  }
                  return null;
                },
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Body',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
