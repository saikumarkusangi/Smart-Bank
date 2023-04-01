import 'dart:math';

import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/speech_controller.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/views/features/home/home.dart';
import 'package:bank/views/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/textFieldController/textfield_controller.dart.dart';
import '../../widgets/widgets.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  void dispose() {
    final textfieldcontroller = Provider.of<TextFieldController>(context);
    // TODO: implement dispose
    super.dispose();
    textfieldcontroller.newAmmount(value: '');
    textfieldcontroller.newrecevierName(value: '');
  }

  final _ammount = TextEditingController();
  final to = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textfieldcontroller = Provider.of<TextFieldController>(context);

    to.text = textfieldcontroller.receviername;
    _ammount.text = textfieldcontroller.ammount;
    @override
    final provider = Provider.of<UserController>(context);
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      appBar: AppBar(
        title: const Text(
          'Send money to',
          style: TextStyle(
              color: ThemeColors.primary,
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 32),
        backgroundColor: ThemeColors.green,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: (provider.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 130,
                          child: Column(children: [
                            (to.text.isNotEmpty)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // AvatarImage(Images.avatars[Random().nextInt(4)],isSVG: true,),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Center(
                                          child: Text(
                                            "sending money to ${to.text}",
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontSize: 18),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    width: 0,
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: to,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontSize: 20),
                              //autofocus: true,
                              decoration: InputDecoration(
                                  hintStyle: const TextStyle(fontSize: 18),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'enter recevier name'.tr,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onFieldSubmitted: (value) =>
                                  FocusScope.of(context)
                                      .requestFocus(focusNode),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'enter recevier name'.tr;
                                }
                                return null;
                              },
                            ),
                          ])),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.2),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  focusNode: focusNode,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter amount'.tr;
                                    }
                                    return null;
                                  },
                                  controller: _ammount,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black87,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 62,
                                  ),
                                  decoration: const InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      prefixIcon: Text(
                                        '₹',
                                        style: TextStyle(
                                            fontSize: 62,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      border: InputBorder.none,
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                          fontSize: 62,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String response = await provider.send(
                                from: provider.nickName,
                                to: to.text.trim(),
                                ammount: int.parse(_ammount.text));

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
                              SpeechController.listen(
                                  "Money successfully sent to ${to.text}");
                              Get.snackbar('Success',
                                  "Money successfully sent to ${to.text}",
                                  snackPosition: SnackPosition.TOP);
                                   provider.currentBalance = '';
                                provider.history.clear();
                              await provider
                                  .userdatafetch(provider.nickName.trim(),
                                      provider.pinNumber.trim())
                                  .whenComplete(() {
                                 
                                Get.to(HomePage());
                              });
                            }
                            print(response);
                            if (response
                                    .split(':')[2]
                                    .replaceAll(RegExp("'"), '') ==
                                " invalid json message format or no message}") {
                              SpeechController.listen(
                                  "no user found with name ${to.text}");
                              Get.snackbar('Something went wrong',
                                  "no user found with name ${to.text}",
                                  snackPosition: SnackPosition.TOP);
                            }

                            if (response
                                    .split(':')[2]
                                    .replaceAll(RegExp("'"), '') ==
                                " maximum transaction amount limit is 100 rupees}") {
                              SpeechController.listen(
                                  "maximum transaction amount limit is 100 rupees");
                              Get.snackbar('Something went wrong',
                                  "maximum transaction amount limit is 100 rupees",
                                  snackPosition: SnackPosition.TOP);
                            }
                          }
                        },
                        color: ThemeColors.green,
                        child: Text(
                          'Send'.tr,
                          style: TextStyle(color: Colors.black, fontSize: 28),
                        ),
                        minWidth: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                      )
                    ],
                  ),
                ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          Visibility(visible: !keyboardIsOpen, child: const Mic()),
    );
  }
}
