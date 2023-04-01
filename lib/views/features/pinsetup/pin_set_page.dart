import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/core.dart';
import 'package:bank/views/features/home/home_page.dart';
import 'package:bank/views/features/record/record_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../controllers/speech_controller.dart';
import '../../widgets/widgets.dart';
import '../home/home.dart';

class PinSetUp extends StatefulWidget {
  PinSetUp(
      {Key? key,
      required this.fullName,
      required this.mobileNumber,
      required this.nickNmae,
      required this.userName})
      : super(key: key);
  String nickNmae;
  String userName;
  String fullName;
  String mobileNumber;

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
    // TODO: implement dispose
    super.dispose();
    pin.dispose();
    upiId.dispose();
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
          backgroundColor: ThemeColors.background,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Image.asset(Images.loginbanner)),
                  ),
                  const Text(
                    'Set Pin',
                    style: TextStyle(
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: upiId,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 20),
                          autofocus: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enter upi id";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintStyle: const TextStyle(fontSize: 18),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'enter upi id'.tr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).requestFocus(focusNode),
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
                          defaultPinTheme: defaultPinTheme,
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
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            final provider = Provider.of<UserController>(
                                context,
                                listen: false);
                            if (formKey.currentState!.validate()) {
                              final res = await NetworkServices.createAccount(
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
                                  'success}') {
                                SpeechController.listen(
                                    "Account created successfully");
                                Get.snackbar(
                                    'Success', "Account created successfully",
                                    snackPosition: SnackPosition.TOP);
                                await provider.userdatafetch(
                                    widget.nickNmae, pin.text.trim());
                                     Get.to( HomePage());
                              } else {
                                SpeechController.listen(res
                                    .split(':')[2]
                                    .replaceAll(RegExp("'"), '')
                                    .toString()
                                    .split(',')[0]
                                    .trim());
                                Get.snackbar(
                                    'Failed',
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
                          child:  Chip(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            label: Text('Create Account'.tr),
                            labelStyle: TextStyle(
                                color: ThemeColors.background, fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              Visibility(visible: !keyboardIsOpen, child: const Mic()),
        ),
      ),
    );
  }
}
