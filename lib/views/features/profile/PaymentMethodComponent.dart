import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../utils/utils.dart';

class PaymentMethodComponent extends StatefulWidget {
  static String tag = '/PaymentMethodComponent';

  const PaymentMethodComponent({super.key});

  @override
  PaymentMethodComponentState createState() => PaymentMethodComponentState();
}

class PaymentMethodComponentState extends State<PaymentMethodComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: backgroundColor, //change your color here
        ),
        backgroundColor: AppColor,
        automaticallyImplyLeading: true,
        title: Text("Payment methods",
            style: primaryTextStyle(
                color: backgroundColor, weight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: backgroundColor),
            onSelected: (dynamic v) {},
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(
                PopupMenuItem(
                    value: 1,
                    child: Text("Send feedback",
                        style: primaryTextStyle(color: ColorBlack))),
              );
              return list;
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(top: 2, bottom: 2, left: 8, right: 8),
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radius(5),
                    border: Border.all(color: Colors.grey[300]!)),
                child:
                    commonCacheImageWidget(bankofbaroda, height: 26, width: 26),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Rp Bank",
                      style: primaryTextStyle(
                          size: 14,
                          color: ColorBlack,
                          weight: FontWeight.bold)),
                  3.height,
                  Text("Savings account", style: secondaryTextStyle(size: 12)),
                  Text("primary account", style: secondaryTextStyle(size: 12)),
                ],
              ).expand(),
            ],
          ),
          30.height,
          Row(
            children: [
              FDottedLine(
                color: AppColor,
                height: 40.0,
                width: 80.0,
                space: 3.0,
                corner: FDottedLineCorner.all(5),
                child: const SizedBox(
                    height: 30.0,
                    width: 50.0,
                    child: Icon(Icons.add, color: AppColor)),
              ),
              14.width,
              Text("ADD BANK ACCOUNT",
                  style: primaryTextStyle(
                      size: 12, color: AppColor, weight: FontWeight.bold))
            ],
          ),
          30.height,
          Row(
            children: [
              FDottedLine(
                color: AppColor,
                height: 40.0,
                width: 80.0,
                space: 3.0,
                corner: FDottedLineCorner.all(5),
                child: const SizedBox(
                  height: 30.0,
                  width: 50.0,
                  child: Icon(Icons.add, color: AppColor),
                ),
              ),
              14.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ADD CARD",
                      style: primaryTextStyle(
                          size: 12, color: AppColor, weight: FontWeight.bold)),
                  4.height,
                  Text("Rp Bank VISA Credit/Debit supported",
                      style: secondaryTextStyle(size: 12)),
                ],
              ).onTap(() {
                dialogWidget(context);
              }).expand()
            ],
          ),
        ],
      ).paddingOnly(top: 20, right: 20, left: 20, bottom: 10),
    );
  }

  dialogWidget(dialogContext) {
    return showDialog(
      barrierDismissible: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            insetPadding: const EdgeInsets.all(50),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Cancel",
                          style: primaryTextStyle(
                              color: AppColor,
                              size: 14,
                              weight: FontWeight.bold))
                      .onTap(() {
                    finish(context);
                  }),
                  20.width,
                  Text("Proceed",
                          style: primaryTextStyle(
                              color: AppColor,
                              size: 14,
                              weight: FontWeight.bold))
                      .onTap(() {}),
                ],
              ).paddingOnly(right: 10, bottom: 10)
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                commonCacheImageWidget(addcarddialogimg,
                    height: 140, fit: BoxFit.fill, width: context.width()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add card to Pay",
                        style: primaryTextStyle(
                            color: ColorBlack, weight: FontWeight.bold)),
                    10.height,
                    Text(
                        "Your card can be used for Tap & Pay, online, and QR code payments. You can limit access to any of these payment types by contacting your bank.",
                        style: primaryTextStyle(color: ColorBlack, size: 13))
                  ],
                ).paddingAll(20)
              ],
            ));
      },
    );
  }
}
