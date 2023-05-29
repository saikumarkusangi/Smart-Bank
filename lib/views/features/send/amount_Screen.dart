import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/NumericPad.dart';
import 'package:bank/utils/images.dart';
import 'package:bank/views/views.dart';
import 'package:bank/views/widgets/PinVerifyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../services/services.dart';

class AmountPage extends StatefulWidget {
  final String image;
  final String nickname;
  final String nicknameeng;
  String amount;

  AmountPage(
      {super.key,
      this.amount = '',
      required this.image,
      required this.nickname,
      required this.nicknameeng});
  @override
  AmountPageState createState() => AmountPageState();
}

class AmountPageState extends State<AmountPage> {
  String? title;
  String text = '';

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    // if (widget.amount.isNotEmpty) {
    //   setState(() {
    //     text = widget.amount;
    //   });
    // }
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          backgroundColor: AppColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close, color: backgroundColor),
            onPressed: () {
              finish(context);
            },
          ),
          actions: [
            PopupMenuButton(
              icon:
                  const Icon(Icons.more_vert_outlined, color: backgroundColor),
              onSelected: (dynamic v) {
                toast('Click');
              },
              itemBuilder: (BuildContext context) {
                List<PopupMenuEntry<Object>> list = [];
                list.add(
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Send feedback",
                        style: TextStyle(color: ColorBlack)),
                  ),
                );
                return list;
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.58,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'pay',
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: backgroundColor,
                        child: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(widget.image)),
                      ),
                    ),
                    5.height,
                    Text("${'Paying to'.tr} ${widget.nickname}",
                        style:
                            primaryTextStyle(color: backgroundColor, size: 18)),
                    15.height,
                    widget.amount.isNotEmpty ?
                    Text('\u{20B9} ${widget.amount}',
                        style: primaryTextStyle(
                            color: backgroundColor,
                            size: 40,
                            weight: FontWeight.bold)):
                             Text('\u{20B9} $text',
                        style: primaryTextStyle(
                            color: backgroundColor,
                            size: 40,
                            weight: FontWeight.bold)),
                    35.height,
                    Container(
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          color: Colors.blue[900]),
                      child: TextField(
                          decoration: InputDecoration.collapsed(
                              hintStyle: primaryTextStyle(
                                  size: 14, color: backgroundColor),
                              hintText: "What is this for?".tr),
                          style: primaryTextStyle(
                              size: 14, color: backgroundColor),
                          textAlign: TextAlign.center),
                    ),
                    40.height,
                  ],
                ),
              ),
            ),
            Visibility(
                visible: !keyboardIsOpen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: NumericKeyboard(
                        onKeyboardTap: (value) {
                          text = text + value;
                          setState(() {});
                        },
                        textColor: Get.isDarkMode ? Colors.white : Colors.black,
                        leftButtonFn: () {
                          setState(() {
                            text = text.substring(0, text.length - 1);
                          });
                        },
                        rightButtonFn: () {
                          if (text.length >= 3) {
                            Fluttertoast.showToast(
                                msg:
                                    "maximum transaction amount limit is 100 rupees");
                            TtsApi.api(
                                "maximum transaction amount limit is one hundred rupees");
                          } else if (text.isEmpty) {
                            Fluttertoast.showToast(msg: "enter amount");
                            TtsApi.api("please enter amount");
                          } else {
                            Get.to(PinVerifyScreen(
                                amount: text,
                                name: widget.nicknameeng,
                                auth: true,
                                page: 'paycomponent'));
                          }
                        },
                        leftIcon: Icon(Icons.backspace_outlined,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                        rightIcon: Icon(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          Icons.arrow_circle_right,
                          size: 38,
                        ),
                      ).paddingBottom(60),
                    ),
                  ],
                )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: AppColor,
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              right: 20,
              left: 20,
            ),
            // right: scrollProvider.visibility ? 20 : 10,
            // left: scrollProvider.visibility ? 20 : 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0))),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mic, color: backgroundColor, size: 26),
              Text('Tap to speak'.tr,
                  style: primaryTextStyle(size: 16, color: backgroundColor))
            ],
          ),
          onPressed: () {
            Get.to(Mic(
              name: widget.nicknameeng,
              currentRoute: '/AmountPage',
            ));
            // ExploreScreen().launch(context);
          },
        ).paddingOnly(bottom: 20),
      ),
    );
  }
}
