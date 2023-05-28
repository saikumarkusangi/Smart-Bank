import 'package:bank/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../views.dart';

class SignUpPage extends StatefulWidget {
  String nickname;
  String username;
  String fullname;
  String mobile;
  SignUpPage(
      {Key? key,
      this.fullname = '',
      this.mobile = '',
      this.nickname = '',
      this.username = ''})
      : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nickName = TextEditingController();
  final userName = TextEditingController();
  final fullName = TextEditingController();
  final mobileNumber = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    nickName.dispose();
    fullName.dispose();
    mobileNumber.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit App',
              style: TextStyle(color: Colors.black),
            ),
            content: const Text(
              'Do you want to exit an App?',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColor),
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.nickname.isNotEmpty) {
      nickName.text = widget.nickname;
    }
    if (widget.username.isNotEmpty) {
      userName.text = widget.username;
    }
    if (widget.mobile.isNotEmpty) {
      mobileNumber.text = widget.mobile;
    }
    if (widget.fullname.isNotEmpty) {
      fullName.text = widget.fullname;
    }
    // userName.text = textfieldcontroller.user;
    // fullName.text = textfieldcontroller.full;
    // mobileNumber.text = textfieldcontroller.mobile;
    // nickName.text = textfieldcontroller.Nick;
    final keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    child: Image.asset(
                  logo,
                  scale: 4,
                )),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create Account'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${'enter'.tr} ${'nick name'.tr}';
                            }
                            return null;
                          },
                          controller: nickName,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 18),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '${'enter'.tr} ${'nick name'.tr}',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: userName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${'enter'.tr} ${'user name'.tr}';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 18),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '${'enter'.tr} ${'user name'.tr}',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: fullName,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${'enter'.tr} ${'full name'.tr}';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 18),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '${'enter'.tr} ${'full name'.tr}',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          // onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(focusNode1) ,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          // focusNode: focusNode1,

                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          controller: mobileNumber,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '${'enter'.tr} ${'Mobile'.tr}';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 18),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '${'enter'.tr} ${'Mobile'.tr}',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          // onFieldSubmitted: (value) => FocusManager.instance.primaryFocus?.unfocus()
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Get.to(PinSetUp(
                                fullName: fullName.text.trim(),
                                mobileNumber: mobileNumber.text.trim(),
                                nickNmae: nickName.text.trim(),
                                userName: userName.text.trim(),
                              ));
                            }
                          },
                          child: Chip(
                            backgroundColor: AppColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            label: Text('Next'.tr),
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Already have an account?".tr,
                              style: const TextStyle(
                                  color: AppColor, fontSize: 18)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(LoginPage()),
                              text: 'Login'.tr,
                              style: const TextStyle(
                                  color: AppColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ]))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Visibility(
            visible: !keyboardIsOpen,
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
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Tap to speak'.tr,
                      style: primaryTextStyle(size: 16, color: AppColor))
                ],
              ),
              onPressed: () {
                Get.to(Mic(
                  currentRoute: '/SignUpPage',
                ));
                // ExploreScreen().launch(context);
              },
            ).paddingOnly(bottom: 16),
          ),
        ),
      ),
    );
  }
}
