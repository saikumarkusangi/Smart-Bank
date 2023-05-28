import 'package:bank/components/commanWidget/app_raised_button_widget.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';


class BusinessBuyNowComponent extends StatefulWidget {
  static String tag = '/BusinessBuyNowComponent';

  const BusinessBuyNowComponent({super.key});

  @override
  BusinessBuyNowComponentState createState() => BusinessBuyNowComponentState();
}

class BusinessBuyNowComponentState extends State<BusinessBuyNowComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: ColorBlack),
          onPressed: () {
            finish(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: ColorBlack),
            onPressed: () async {
              await Share.share('share Link');
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: ColorBlack),
            onSelected: (dynamic v) {
              toast('Click');
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(
                const PopupMenuItem(value: 1, child: Text("Report Offer", style: TextStyle(color: ColorBlack))),
              );
              list.add(
                const PopupMenuItem(value: 1, child: Text("Send Feedback", style: TextStyle(color: ColorBlack))),
              );
              return list;
            },
          )
        ],
      ),
      bottomNavigationBar: AppRaisedButton(
              width: context.width(),
              height: 50,
              color: AppColor,
              title: 'Buy now',
              titleColor: backgroundColor,
              titleSize: 14,
              onPressed: () {
                toast('buy now');
              },
              borderRadius: 25)
          .paddingOnly(left: 16, right: 16, bottom: 16),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 220,
            width: context.width(),
            color: Colors.pink[50],
            child: Image.asset(buynow, height: 140, width: 140),
          ),
          ListView(shrinkWrap: true, physics: const ClampingScrollPhysics(), children: [
            Container(
              height: context.height(),
              margin: const EdgeInsets.only(top: 200),
              decoration: boxDecorationWithRoundedCorners(backgroundColor: backgroundColor, borderRadius: radiusOnly(topRight: 14, topLeft: 14), border: Border.all(color: backgroundColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("title".toUpperCase(), style: primaryTextStyle(color: ColorBlack, size: 12, weight: FontWeight.bold)).paddingTop(16),
                  15.height,
                  Text("Get 8% off on Trip Flights", style: primaryTextStyle(color: ColorBlack, size: 24)),
                  5.height,
                  Text("Make a transaction on the Trip Spot and save 8 % (up to \u20B9 1000).", style: primaryTextStyle(color: ColorBlack, size: 15)),
                  20.height,
                  Text("Offer dates", style: primaryTextStyle(color: ColorBlack, size: 14, weight: FontWeight.bold)),
                  5.height,
                  Text("Offer expires 31 Feb 2021", style: primaryTextStyle(color: ColorBlack, size: 14)),
                  20.height,
                  Text("Details", style: primaryTextStyle(color: ColorBlack, size: 14, weight: FontWeight.bold)),
                  5.height,
                  Text(
                      "Flat ₹250 cashback on payments via ay (UPI, Cards) during the offer period, on trip android app, on a minimum order value of ₹1000.Cashback will be applied only once on the first valid payment during the offer period per user",
                      style: primaryTextStyle(color: ColorBlack, size: 14)),
                  20.height,
                  Text("Terms and Conditions", style: primaryTextStyle(color: ColorBlack, size: 14, weight: FontWeight.bold)),
                  5.height,
                  Text(
                      "In case the ay wallet limit for the month has been reached, the cashback will be credited on the first business day of the next month.Refunds would be processed on a pro-rata basis.In case where cashback has been credited to Your ay wallet and You cancel the transaction and you seek a refund, cash back credited to Non-withdrawable section will be adjusted to withdrawable at the time of refunds if the same is not utilized by the Customer.This offer might not be clubbed with any offer made available to you by an issuer of any Debit Card or Credit Card or any bank for shopping on trip platform(s). ay isn’t responsible for any offer beyond what is mentioned above.ay has the right to amend the terms & conditions, end the offer, or call back any or all of its offers without prior notice.In case of dispute, ay reserves the right to take the final decision on the interpretation of these terms & conditions.",
                      style: primaryTextStyle(color: ColorBlack, size: 14)),
                ],
              ).paddingOnly(left: 16, right: 16, bottom: 16),
            ),
          ]),
        ],
      ),
    );
  }
}
