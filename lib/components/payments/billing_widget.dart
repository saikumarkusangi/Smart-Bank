import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/utils.dart';
import '../../views/widgets/widgets.dart';

Widget rechargeWidget(String image, String title) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(22))),
    child: Row(
      children: [
        Image.asset(image, height: 22, width: 22, color: AppColor),
        12.width,
        Text(title,
            style: primaryTextStyle(
                size: 12, color: ColorBlack, weight: FontWeight.bold)),
      ],
    ),
  );
}

Widget moneyWidget(String image, String title, style) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: AppColor,
        radius: 25,
        child:
            Image.asset(image, height: 28, width: 28, color: backgroundColor),
      ),
      10.height,
      Text(title, style: style, textAlign: TextAlign.center)
    ],
  );
}

dialogWidget(dialogContext) {
  return showDialog(
    context: dialogContext,
    builder: (context) {
      return AlertDialog(
        title: Text('Pay to'.tr,
            style: primaryTextStyle(
                color: ColorBlack, size: 20, weight: FontWeight.bold),
            textAlign: TextAlign.start),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(upiidicon,
                    height: 20, width: 20, color: ColorBlack),
                10.width,
                Text('UPI ID',
                    style: primaryTextStyle(
                        size: 12, color: ColorBlack, weight: FontWeight.bold))
              ],
            ).onTap(() {
              finish(context);
              upiDialogWidget(context);
            }),
            40.height,
            Row(
              children: [
                commonCacheImageWidget(qrscanner, height: 20, width: 20),
                10.width,
                Text('OPEN CODE SCANNER',
                        style: primaryTextStyle(
                            size: 12,
                            color: ColorBlack,
                            weight: FontWeight.bold))
                    .onTap(() {
                  QrScannerScreen(screenName: "PeopleAndBillsScreen")
                      .launch(context);
                })
              ],
            ),
          ],
        ),
      );
    },
  );
}

upiDialogWidget(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter UPI ID',
            style: primaryTextStyle(
                color: ColorBlack, size: 20, weight: FontWeight.bold),
            textAlign: TextAlign.start),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("To:",
                    style: secondaryTextStyle(size: 14, color: Colors.grey)),
                TextFormField(
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.grey[300],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]!)),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                    )).expand(),
              ],
            )
          ],
        ).paddingTop(20),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Cancel".toUpperCase(),
                      style: primaryTextStyle(
                          size: 13, color: AppColor, weight: FontWeight.bold))
                  .onTap(() {
                finish(context);
              }),
              20.width,
              Text("Verify".toUpperCase(),
                      style: primaryTextStyle(
                          size: 13, color: ColorBlack, weight: FontWeight.bold))
                  .onTap(() {
                toast("verify");
              }),
            ],
          ).paddingOnly(bottom: 15, right: 15, top: 15)
        ],
      );
    },
  );
}
