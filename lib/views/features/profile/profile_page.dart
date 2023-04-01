import 'dart:math';

import 'package:bank/controllers/speech_controller.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:bank/core.dart';
import 'package:bank/views/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Future<void> speechDetails() async {
    final provider = Provider.of<UserController>(context);
    await SpeechController.listen("your personal details are".tr);
    await SpeechController.listen("Nick Name ${provider.nickName}");
    await SpeechController.listen("User Name ${provider.userName}");
    await SpeechController.listen("Full Name ${provider.fullName}");
    await SpeechController.listen("Mobile Number ${provider.phoneNumber}");
    await SpeechController.listen("Upi id ${provider.upiId}");
  }

  @override
  Widget build(BuildContext context) {
    if (Get.currentRoute == '/ProfilePage') {
      print('tsssssss');
      speechDetails();
    }
    final provider = Provider.of<UserController>(context);

    return Scaffold(
      floatingActionButton: const Mic(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        title: Text(
          'profile'.tr,
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                        child: Column(
                      children: [
                        AvatarImage(Images.avatars[Random().nextInt(1)],
                            isSVG: false, width: 100, height: 100),
                      ],
                    )),
                    const SizedBox(
                      width: 15,
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "nick name".tr,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                        subtitle: Text(
                          provider.nickName,
                          style: const TextStyle(fontSize: 24),
                        ),
                        trailing: InkWell(
                            onTap: () => _displayTextInputDialog(
                                context,
                                'nick name'.tr,
                                'nick_name',
                                provider.nickName.trim(),
                                provider.pinNumber.trim()),
                            child: Text(
                              'edit'.tr,
                              style: const TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        trailing: InkWell(
                            onTap: () => _displayTextInputDialog(
                                context,
                                'user name'.tr,
                                'user_name',
                                provider.nickName.trim(),
                                provider.pinNumber.trim()),
                            child: Text(
                              'edit'.tr,
                              style: const TextStyle(fontSize: 18),
                            )),
                        title: Text(
                          "user name".tr,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                        subtitle: Text(
                          provider.userName,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        trailing: InkWell(
                            onTap: () => _displayTextInputDialog(
                                context,
                                'full name'.tr,
                                'full_name',
                                provider.nickName.trim(),
                                provider.pinNumber.trim()),
                            child: Text(
                              'edit'.tr,
                              style: const TextStyle(fontSize: 18),
                            )),
                        title: Text(
                          "full name".tr,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                        subtitle: Text(
                          provider.fullName,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        trailing: InkWell(
                            onTap: () => _displayTextInputDialog(
                                context,
                                'mobile'.tr,
                                'mob_number',
                                provider.nickName.trim(),
                                provider.pinNumber.trim()),
                            child: Text(
                              'edit'.tr,
                              style: const TextStyle(fontSize: 18),
                            )),
                        title: Text(
                          "mobile".tr,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                        subtitle: Text(
                          provider.phoneNumber,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        trailing: InkWell(
                            onTap: () => _displayTextInputDialog(
                                context,
                                'upi id'.tr,
                                'upi_id',
                                provider.nickName.trim(),
                                provider.pinNumber.trim()),
                            child: Text(
                              'edit'.tr,
                              style: const TextStyle(fontSize: 18),
                            )),
                        title: Text(
                          "upi id".tr,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                        subtitle: Text(
                          provider.upiId,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          final res = await NetworkServices.deleteUser(
                              provider.nickName.trim());
                          //   Get.snackbar(res., message)
                          // SpeechController.flutterTts.stop();
                          //  Get.to(LoginPage());
                        } catch (e) {
                          rethrow;
                        }
                      },
                      child: Chip(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        label: Text('Delete Account'.tr),
                        labelStyle: TextStyle(
                            color: ThemeColors.secondary, fontSize: 26),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        try {
                          await SpeechController.listen(
                              'you have logged out'.tr);
                          Get.snackbar('success'.tr, 'you have logged out'.tr);
                          provider.clearData();
                          prefs.setString('nickName', '');
                          prefs.setString('pin', '');
                          prefs.setBool('user',false);
                          Get.off(const LoginPage());
                          print(provider.fullName);
                        } catch (e) {
                          rethrow;
                        }
                      },
                      child: Chip(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        label: Text('Log out'.tr),
                        labelStyle: const TextStyle(
                            color: ThemeColors.secondary, fontSize: 26),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _displayTextInputDialog(
    BuildContext context, title, key, nickname, pin) async {
  final provider = Provider.of<UserController>(context, listen: false);
  final textFieldController = TextEditingController();

  // String value = '';
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${'update'.tr} $title'),
          content: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'empty input'.tr;
              }
              return null;
            },
            // onChanged: (val) {
            //   value = val;
            // },

            controller: textFieldController,
            decoration: InputDecoration(hintText: '${"new".tr} $title'),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('update'.tr),
              onPressed: () async {
                final res = await NetworkServices.update(
                    key,
                    textFieldController.text.toString().trim(),
                    provider.nickName.trim());
                if (res
                        .toString()
                        .split(':')[1]
                        .replaceAll(RegExp("'"), '')
                        .replaceAll(RegExp('}'), '')
                        .toString()
                        .removeAllWhitespace ==
                    'success') {
                  await provider.clearData();
                  await provider.userdatafetch(nickname, pin);
                  Get.snackbar('success'.tr, 'updated successfully'.tr);
                  //  await SpeechController.listen('updated successfully'.tr);
                } else {
                  Get.snackbar('failed'.tr, 'failed'.tr);
                  // await SpeechController.listen('failed'.tr);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
