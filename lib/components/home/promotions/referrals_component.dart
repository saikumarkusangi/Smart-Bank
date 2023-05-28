import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../utils/utils.dart';

class ReferralsComponent extends StatefulWidget {
  static String tag = '/ReferralsComponent';

  const ReferralsComponent({super.key});

  @override
  ReferralsComponentState createState() => ReferralsComponentState();
}

class ReferralsComponentState extends State<ReferralsComponent> {
  var searchController = TextEditingController();
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isEnable) {
          hideKeyboard(context);
          isEnable = false;

          setState(() {});
          return false;
        }
        return !isEnable;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: AppColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              if (isEnable) {
                hideKeyboard(context);
                isEnable = false;

                setState(() {});
                return;
              }
              finish(context);
            },
          ),
          title: isEnable
              ? TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      hintText: 'Search Friends',
                      hintStyle: secondaryTextStyle(size: 12),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.black)),
                  onTap: () {
                    //   hideKeyboard(context);
                  },
                )
              : const Text(""),
          actions: [
            IconButton(
              icon: isEnable
                  ? Container()
                  : const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                isEnable = true;
                setState(() {});
              },
            ).visible(!isEnable)
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(referralbg), fit: BoxFit.cover)),
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\u20B951 earned",
                      style: primaryTextStyle(size: 26, color: ColorBlack)),
                  10.height,
                  Text("For referring 1 friend",
                      style: primaryTextStyle(size: 18, color: ColorBlack)),
                ],
              ).paddingTop(10),
            ),
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(top: 160),
                  decoration: boxDecorationWithRoundedCorners(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: radius(20),
                      border: Border.all(color: backgroundColor)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue[100],
                            radius: 20,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.next_plan_outlined,
                                  color: AppColor),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                          ),
                          10.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("32y52b",
                                  style: primaryTextStyle(
                                      size: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      weight: FontWeight.bold)),
                              3.height,
                              Text("Your referral code",
                                  style: secondaryTextStyle(
                                      size: 12,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black))
                            ],
                          ),
                          const Spacer(),
                          Text("Share",
                              style: primaryTextStyle(
                                  size: 14,
                                  color: AppColor,
                                  weight: FontWeight.bold))
                        ],
                      ),
                      10.height,
                      Divider(color: Colors.grey[300], thickness: 1),
                      10.height,
                    ],
                  ),
                )
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: AppColor,
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
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
              currentRoute: '/ReferralsPage',
            ));
          },
        ).paddingOnly(bottom: 16),
      ),
    );
  }
}
