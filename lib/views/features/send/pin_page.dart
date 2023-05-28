import 'package:bank/controllers/user_controller.dart';
import 'package:bank/services/services.dart';
import 'package:bank/views/views.dart';
import 'package:bank/views/widgets/paid_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class PinPage extends StatelessWidget {
  PinPage({super.key, required this.to, required this.ammount});
  final to;
  final ammount;
  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 32),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Image.network(
            'https://logodix.com/logo/1763566.png',
            width: 100,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Enter Your Pin".tr,
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Pinput(
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            MaterialButton(
              onPressed: () {
                (val) async {
                  if (formKey.currentState!.validate()) {
                    String response = await provider.send(
                        from: provider.nickName,
                        to: to.text.trim(),
                        ammount: int.parse(ammount.text));

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
                      TtsApi.api("Money successfully sent to ${to.text}");
                      Get.snackbar(
                          'Success', "Money successfully sent to ${to.text}",
                          backgroundColor: Colors.white,
                          snackPosition: SnackPosition.TOP);
                      provider.currentBalance = '';
                      provider.history.clear();
                      await provider
                          .userdatafetch(provider.nickName.trim(),
                              provider.pinNumber.trim())
                          .whenComplete(() {
                        Get.off(const PaidSucessScreen());
                      });
                    }
                    if (response.split(':')[2].replaceAll(RegExp("'"), '') ==
                        " invalid json message format or no message}") {
                      TtsApi.api("no user found with name ${to.text}");
                      Get.snackbar('Something went wrong',
                          "no user found with name ${to.text}",
                          snackPosition: SnackPosition.TOP,backgroundColor: Colors.white);
                    }

                    if (response.split(':')[2].replaceAll(RegExp("'"), '') ==
                        " maximum transaction amount limit is 100 rupees}") {
                      TtsApi.api(
                          "maximum transaction amount limit is 100 rupees");
                      Get.snackbar('Something went wrong',
                          "maximum transaction amount limit is 100 rupees",
                          snackPosition: SnackPosition.TOP,backgroundColor: Colors.white);
                    }
                  }
                };
              },
              color: Colors.green,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: Text(
                'Send'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
            )
          ],
        ),
      ),
    );
  }
}
