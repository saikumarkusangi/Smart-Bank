import 'dart:async';
import 'package:bank/controllers/balance_controller.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/models/models.dart';
import 'package:bank/services/tts_api.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/views/features/home/main_screen.dart';
import 'package:bank/views/features/transactions/transaction_item.dart';
import 'package:bank/views/features/transactions/transcations.dart';
import 'package:bank/views/widgets/paid_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class PinVerifyScreen extends StatefulWidget {
  static String tag = '/PinVerifyScreen';
  bool auth;
  String page;
  String amount;
  String name;
  PinVerifyScreen(
      {super.key,
      required this.auth,
      this.page = '',
      this.amount = '',
      this.name = ''});

  @override
  PinVerifyScreenState createState() => PinVerifyScreenState();
}

class PinVerifyScreenState extends State<PinVerifyScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;
  GoogleTranslator translator = GoogleTranslator();

  Future<String> trans(msg) {
    return translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) {
      return value.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor,
          leading: widget.auth
              ? IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                )
              : const Icon(
                  Icons.lock,
                  size: 0,
                )),
      body: _showLockScreen(
        context,
        opaque: false,
        circleUIConfig: const CircleUIConfig(
            borderColor: Colors.white, fillColor: Colors.white, circleSize: 20),
        keyboardUIConfig: const KeyboardUIConfig(
            digitBorderWidth: 2, primaryColor: Colors.white),
        cancelButton: const Icon(Icons.arrow_back, color: Colors.blue),
        digits: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
      ),
    );
  }

  _showLockScreen(context,
      {required bool opaque,
      CircleUIConfig? circleUIConfig,
      KeyboardUIConfig? keyboardUIConfig,
      Widget? cancelButton,
      List<String>? digits}) {
    final provider = Provider.of<UserController>(context);
    final balanceprovider = Provider.of<BalanceProvider>(context);
    return PasscodeScreen(
      title: Column(
        children: [
          !widget.auth
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : 0.height,
           Text(
            'Enter your 6 digits pin'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ],
      ),
      circleUIConfig: circleUIConfig,
      keyboardUIConfig: keyboardUIConfig,
      passwordEnteredCallback: (String enteredPasscode) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isValid = prefs.getString('pin') == enteredPasscode;
        _verificationNotifier.add(isValid);
        if (isValid) {
          // Fluttertoast.showToast(msg: 'success');
          if (widget.page == 'paycomponent' && widget.auth) {
            String response = await provider.send(
                from: provider.nickName,
                to: widget.name,
                ammount: int.parse(widget.amount));

            if (response
                    .split(':')[1]
                    .replaceAll(RegExp("'"), '')
                    .substring(
                        0,
                        response
                                .toString()
                                .split(':')[1]
                                .replaceAll(RegExp("'"), '')
                                .length -
                            1)
                    .trim() ==
                'success') {
              String msg =
                  await trans("${'Money successfully sent to'.tr} ${widget.name}");
              TtsApi.api(msg);
              Get.snackbar(
                  'Success'.tr, "${'Money successfully sent to'.tr} ${widget.name}",
                  snackPosition: SnackPosition.TOP,backgroundColor: Colors.white);
              provider.currentBalance = '';
              provider.history.clear();
              await provider
                  .userdatafetch(
                      provider.nickName.trim(), provider.pinNumber.trim())
                  .whenComplete(() async {
                Get.off(const PaidSucessScreen());
              });
            }
            if (response.split(':')[2].replaceAll(RegExp("'"), '') ==
                " invalid json message format or no message}") {
              TtsApi.api("No user found with name".tr);
              Get.snackbar('Something went wrong'.tr, "No user found with name ".tr,
                  snackPosition: SnackPosition.TOP,backgroundColor: Colors.white);
            }

            if (response.split(':')[2].replaceAll(RegExp("'"), '') ==
                " maximum transaction amount limit is 100 rupees".tr) {
              TtsApi.api("maximum transaction amount limit is 100 rupees".tr);
              Get.snackbar('Something went wrong'.tr,
                  "maximum transaction amount limit is 100 rupees".tr,
                  snackPosition: SnackPosition.TOP,backgroundColor: Colors.white);
            }
          } else if (widget.page == 'balance' && widget.auth) {
            balanceprovider.back();
            Get.to(const MainScreen());
          } else {
            Get.to(const MainScreen());
          }
        }
      },
      cancelButton: cancelButton!,
      deleteButton: Text('Delete'.tr,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          semanticsLabel: 'Delete'.tr),
      shouldTriggerVerification: _verificationNotifier.stream,
      backgroundColor: AppColor,
      digits: digits,
      passwordDigits: 6,
    );
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}
