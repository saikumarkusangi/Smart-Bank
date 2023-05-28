import 'package:bank/utils/Colors.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 32),
        backgroundColor: AppColor,
        elevation: 0,
        //title:const Text('Request money to',style: TextStyle(color: ThemeColors.primary),),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 100,
                    child: Column(children: [
                      Text(
                        'Request money to'.tr,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '',
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          ),
                        ],
                      )
                    ])),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.2),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          autofocus: true,
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
                              prefix: Text(
                                '₹',
                                style: TextStyle(
                                    fontSize: 62, fontWeight: FontWeight.bold),
                              ),
                              border: InputBorder.none,
                              hintText: '0',
                              hintStyle: TextStyle(
                                  fontSize: 62, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: AppColor,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  child: Text(
                    'Request'.tr,
                    style: TextStyle(color: Colors.black, fontSize: 28),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: backgroundColor,
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
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
            // ExploreScreen().launch(context);
          },
        ).paddingOnly(bottom: 16),
      ),
    );
  }
}
