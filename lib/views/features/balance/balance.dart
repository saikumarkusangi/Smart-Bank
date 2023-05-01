import 'package:bank/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../constants/colors.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets/mic.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  // check() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  // }

  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final pinProvider = Provider.of<UserController>(context);
    // check();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: ThemeColors.pink,
        title:const Text(
          'Check Account Balance',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: ThemeColors.secondary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Your Pin".tr,
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
              const SizedBox(
                height: 10,
              ),
              Pinput(
                controller: pinController,
                closeKeyboardWhenCompleted: true,
                obscureText: true,
                length: 6,
                autofocus: true,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Enter 6 digits pin'.tr;
                  }
                  return null;
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  final amount =
                      Provider.of<UserController>(context, listen: false);
                  final mi = Provider.of<MicController>(context, listen: false);
                  mi.text.clear();
                  if (pinController.text == pinProvider.pinNumber.trim()) {
                    if (amount.balance) {
                      amount.showBalance(false);
                      Navigator.pop(context);
                    } else {
                      SpeechController.listen(
                          "${"your account balance is ruppess".tr}${amount.currentBalance}");

                      amount.showBalance(true);
                      Navigator.pop(context);
                    }
                  } else {
                    SpeechController.listen("please check your pin".tr);
                    Get.snackbar(
                        'please check your pin'.tr, 'please check your pin'.tr);
                  }
                },
                child: Chip(
                  backgroundColor: Colors.black,
                  padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  label: Text('Login'.tr),
                  labelStyle:
                     const TextStyle(color: ThemeColors.secondary, fontSize: 26),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const Mic(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
