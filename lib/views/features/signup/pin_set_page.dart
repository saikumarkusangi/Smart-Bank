import 'package:bank/controllers/controllers.dart';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../services/services.dart';

class PinSetUp extends StatefulWidget {
  const PinSetUp(
      {Key? key,
      required this.fullName,
      required this.mobileNumber,
      required this.nickNmae,
      required this.userName})
      : super(key: key);
  final String userName;
  final String nickNmae;
  final String fullName;
  final String mobileNumber;

  @override
  State<PinSetUp> createState() => _PinSetUpState();
}

class _PinSetUpState extends State<PinSetUp> {
  final upiId = TextEditingController();
  final pin = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    pin.dispose();
    upiId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
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
                  5.width,
                  Text('Tap to speak'.tr,
                      style: primaryTextStyle(size: 16, color: AppColor))
                ],
              ),
              onPressed: () {
                Get.to(Mic(
                  currentRoute: '/loginPage',
                ));
              },
            ).paddingOnly(bottom: 16),
          ),
          backgroundColor: AppColor,
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    height: 40,
                  ),
                  Text(
                    'Set Pin'.tr,
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
                          horizontal: 20, vertical: 20),
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
                              controller: upiId,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              // autofocus: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter upi id".tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 18),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter upi id'.tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(focusNode),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Pinput(
                              obscureText: true,
                              controller: pin,
                              closeKeyboardWhenCompleted: true,
                              length: 6,
                              focusNode: focusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter six digit pin".tr;
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
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColor),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyWith(
                                textStyle: const TextStyle(
                                    color: Colors.redAccent, fontSize: 32),
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  color: fillColor,
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Colors.redAccent, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () async {
                                final provider = Provider.of<UserController>(
                                    context,
                                    listen: false);
                                if (formKey.currentState!.validate()) {
                                  final res =
                                      await NetworkServices.createAccount(
                                          widget.nickNmae,
                                          widget.fullName,
                                          pin.text.trim(),
                                          widget.mobileNumber,
                                          upiId.text.trim(),
                                          widget.userName);

                                  if (res
                                          .split(':')[1]
                                          .replaceAll(RegExp("'"), '')
                                          .toString()
                                          .trim() ==
                                      'Success'.tr) {
                                    TtsApi.api("Account created successfully".tr);
                                    Get.snackbar('Success'.tr,
                                        "Account created successfully".tr,
                                        backgroundColor: Colors.white,
                                        snackPosition: SnackPosition.TOP);
                                    await provider.userdatafetch(
                                        widget.nickNmae, pin.text.trim());
                                    Get.off(const MainScreen());
                                  } else {
                                    TtsApi.api(res
                                        .split(':')[2]
                                        .replaceAll(RegExp("'"), '')
                                        .toString()
                                        .split(',')[0]
                                        .trim());
                                    Get.snackbar(
                                        backgroundColor: Colors.white,
                                        'Failed'.tr,
                                        res
                                            .split(':')[2]
                                            .replaceAll(RegExp("'"), '')
                                            .toString()
                                            .split(',')[0]
                                            .trim(),
                                        snackPosition: SnackPosition.TOP);
                                  }
                                }
                              },
                              child: Chip(
                                backgroundColor: AppColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                label: Text('Create Account'.tr),
                                labelStyle: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        ),
                      ))
                ]),
          ),
        ),
      ),
    );
  }
}
