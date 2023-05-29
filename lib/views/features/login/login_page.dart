import 'package:bank/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../controllers/controllers.dart';
import '../../../services/services.dart';
import '../../views.dart';

class LoginPage extends StatefulWidget {
  String nickname;
  LoginPage({Key? key, this.nickname = ''}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nickNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  bool _isloading = false;
  @override
  void dispose() {
    nickNameController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textfieldcontroller = Provider.of<TextFieldController>(context);
    final provider = Provider.of<UserController>(context);
    if (widget.nickname.isNotEmpty) {
      nickNameController.text = widget.nickname;
    }

    // voice() async {
    //   if (finalnickname.isEmpty) {
    //     print(
    //         '####################@@@@@@@@@@@@@@@@@@@@@@@@@@######################' +
    //             finalnickname);
    //     await TtsApi.api("say your name".tr);
    //   } else {
    //     await TtsApi.api("write your pin".tr);
    //   }
    // }

    //final histroy = Provider.of<HistoryController>(context);
    //  nickNameController.text = textfieldcontroller.nickname;

    Future<void> login() async {
      setState(() {
        _isloading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (formKey.currentState!.validate()) {
        try {
          if (prefs.getString('nickName') == null) {
            await provider.userdatafetch(
                nickNameController.text.trim(), pinController.text.trim());

            if (pinController.text == provider.pinNumber.trim()) {
              setState(() {
                _isloading = false;
              });
              TtsApi.api("Successfully logged in".tr);
              Get.snackbar("Success".tr, "You are successfully logged in".tr,
                  backgroundColor: Colors.white);
              Get.off(const MainScreen());
              prefs.setBool('user', true);
              prefs.setString('nickName', provider.nickName.trim());
              prefs.setString('pin', provider.pinNumber.trim());
              textfieldcontroller.newNickName(value: 'nick name'.tr);
            }
          } else {
            await provider.userdatafetch(
                nickNameController.text.trim(), pinController.text.trim());

            if (pinController.text == provider.pinNumber.trim()) {
              setState(() {
                _isloading = false;
              });
              TtsApi.api("Successfully logged in".tr);
              Get.snackbar("Success".tr, "You are successfully logged in".tr,
                  backgroundColor: Colors.white);
              Get.off(const MainScreen());
              prefs.setBool('user', true);
              prefs.setString('nickName', provider.nickName.trim());
              prefs.setString('pin', provider.pinNumber.trim());
              textfieldcontroller.newNickName(value: 'nick name'.tr);
            } else {
              setState(() {
                _isloading = false;
              });
              nickNameController.text = '';
              pinController.text = '';
              TtsApi.api("You have entered incorrect password".tr);
              Get.snackbar("Failed".tr, "Incorrect Password".tr,
                  backgroundColor: Colors.white);
            }
          }
        } catch (e) {
          setState(() {
            _isloading = false;
          });
          nickNameController.text = '';
          pinController.text = '';
          TtsApi.api(
              "${"No user Exists with nick name".tr}${nickNameController.text}");
          Get.snackbar("Failed".tr,
              "${"No user Exists with nick name".tr}${nickNameController.text}",
              backgroundColor: Colors.white);
        }
      }
    }

    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Exit App'.tr,
                style: TextStyle(color: Colors.black),
              ),
              content: Text(
                'Do you want to exit an App?'.tr,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColor),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'.tr),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColor),
                  onPressed: () => SystemNavigator.pop(),
                  child: Text('Yes'.tr),
                ),
              ],
            ),
          ) ??
          false;
    }

    print('###############################################' +
        widget.nickname.isEmpty.toString() +
        nickNameController.text.isEmpty.toString());
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColor),
      ),
    );

    return WillPopScope(
        onWillPop: showExitPopup,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: AppColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        child: Image.asset(
                      logo,
                      scale: 4,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Login'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 2,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(5, 10))
                          ]),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nickNameController,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 18),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Nick name'.tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(focusNode),
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
                              focusNode: focusNode,
                              closeKeyboardWhenCompleted: true,
                              obscureText: true,
                              length: 6,
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColor),
                                ),
                              ),
                              controller: pinController,
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
                                    color: AppColor,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => login(),
                              child: Chip(
                                backgroundColor: AppColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                label: _isloading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text('Login'.tr),
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Don't have an account? ".tr,
                                  style: const TextStyle(
                                      color: AppColor, fontSize: 18)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(SignUpPage()),
                                  text: 'Register'.tr,
                                  style: const TextStyle(
                                      color: AppColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ]))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
              return Visibility(
                visible: !isKeyboardVisible,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 20, left: 20),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.mic, color: AppColor, size: 26),
                      Text('Tap to speak'.tr,
                          style: primaryTextStyle(size: 16, color: AppColor))
                    ],
                  ),
                  onPressed: () {
                    Get.to(Mic(
                      currentRoute: '/LoginPage',
                    ));
                  },
                ).paddingOnly(bottom: 16),
              );
            }),
          ),
        ));
  }
}
