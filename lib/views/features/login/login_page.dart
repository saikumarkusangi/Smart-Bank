import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/controllers/history_controller.dart';
import 'package:bank/controllers/textFieldController/textfield_controller.dart.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/core.dart';
import 'package:bank/views/features/home/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views.dart';
import '../../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  voice() async {
    await SpeechController.listen("say your name".tr);
    if (nickNameController.text.isNotEmpty) {
      await SpeechController.listen("write your pin".tr);
    }
  }

  @override
  void initState() {
    super.initState();
    voice();
  }

  TextEditingController nickNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nickNameController.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textfieldcontroller = Provider.of<TextFieldController>(context);
    final provider = Provider.of<UserController>(context);
    //final histroy = Provider.of<HistoryController>(context);
  
    nickNameController.text = textfieldcontroller.nickname;

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    const focusedBorderColor = Colors.white;
    const fillColor = Colors.white;
    const borderColor = Colors.blue;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 32,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    Future<void> login() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (formKey.currentState!.validate()) {
        try {
          print('**********************');
          print(prefs.getString('nickName'));

          if (prefs.getString('nickName') == null) {
            print('############################');
            await provider.userdatafetch(
                nickNameController.text.trim(), pinController.text.trim());

            if (pinController.text == provider.pinNumber.trim()) {
              SpeechController.listen("you are successfully logged in".tr);
              Get.snackbar("Success".tr, "you are successfully logged in".tr);
              Get.off(HomePage());
              prefs.setBool('user', true);
              print(provider.nickName.trim());
              prefs.setString('nickName', provider.nickName.trim());
              prefs.setString('pin', provider.pinNumber.trim());
              textfieldcontroller.newNickName(value: 'nick name'.tr);
            }
          } else {
            print('#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
            await provider.userdatafetch(
                nickNameController.text.trim(), pinController.text.trim());

            if (pinController.text == provider.pinNumber.trim()) {
              SpeechController.listen("you are successfully logged in".tr);
              Get.snackbar("Success".tr, "you are successfully logged in".tr);
              Get.off(const HomePage());
              prefs.setBool('user', true);
              prefs.setString('nickName', provider.nickName.trim());
              prefs.setString('pin', provider.pinNumber.trim());
              textfieldcontroller.newNickName(value: 'nick name'.tr);
            } else {
              nickNameController.text = '';
              pinController.text = '';
              SpeechController.listen("you have entered incorrect password".tr);
              Get.snackbar("Failed".tr, "Incorrect Password".tr,
                  backgroundColor: Colors.white);
            }
          }
        } catch (e) {
          print(e.toString() + '&&&&&&&&&&&&&&&&');
          nickNameController.text = '';
          pinController.text = '';
          SpeechController.listen(
              "No user Exits with nick name".tr + "${nickNameController.text}");
          Get.snackbar("Failed".tr,
              "No user Exits with nick name".tr + "${nickNameController.text}",
              backgroundColor: Colors.white);
        }
      }
    }

// else {
//               nickNameController.text = '';
//               pinController.text = '';
//               SpeechController.listen("you have entered incorrect password".tr);
//               Get.snackbar("Failed".tr, "Incorrect Password".tr,
//                   backgroundColor: Colors.white);
//             }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ThemeColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Image.asset(Images.loginbanner)),
                ),
                Text(
                  'Login'.tr,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 32),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nickNameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 20),
                          //autofocus: true,
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 18),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'nick name'.tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).requestFocus(focusNode),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter nick name'.tr;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Pinput(
                          closeKeyboardWhenCompleted: true,
                          obscureText: true,
                          length: 6,
                          controller: pinController,
                          defaultPinTheme: defaultPinTheme,
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Enter 6 digits pin';
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
                                color: focusedBorderColor,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyWith(
                            textStyle: const TextStyle(
                                color: Colors.redAccent, fontSize: 32),
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border:
                                  Border.all(color: Colors.redAccent, width: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => login(),
                  child: Chip(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    label: Text('Login'.tr),
                    labelStyle:
                        TextStyle(color: ThemeColors.background, fontSize: 26),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Don't have an account? ".tr,
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(const SignUpPage()),
                      text: 'Register'.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ]))
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            Visibility(visible: !keyboardIsOpen, child: const Mic()),
      ),
    );
  }
}
