
import 'package:bank/components/commanWidget/app_raised_button_widget.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ReferralCodeComponent extends StatefulWidget {

  const ReferralCodeComponent({super.key});

  @override
  ReferralCodeComponentState createState() => ReferralCodeComponentState();
}

class ReferralCodeComponentState extends State<ReferralCodeComponent> {

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text("Referral code", style: primaryTextStyle(size: 16, color: ColorBlack, weight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: ColorBlack),
            onSelected: (dynamic v) {
              toast('Click');
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(
                const PopupMenuItem(value: 1, child: Text("Send Feedback", style: TextStyle(color: ColorBlack))),
              );
              return list;
            },
          )
        ],
      ),
      bottomNavigationBar: AppRaisedButton(
        title: 'Invite friends',
        height: 50,
        titleSize: 14,
        onPressed: () {},
        borderRadius: 25,
      ).paddingOnly(left: 20, right: 20, bottom: 20),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(referralcodebg, height: 160, fit: BoxFit.fill, width: MediaQuery.of(context).size.width),
            30.height,
            Row(
              children: [
                Image.asset(checkmarkgreen, height: 28, width: 28),
                10.width,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Referral reward earned', style: primaryTextStyle(size: 13, color: Colors.green[500])),
                      TextSpan(text: '  (87mt6s)!', style: primaryTextStyle(size: 13, weight: FontWeight.bold, color: Colors.green[500]))
                    ],
                  ),
                ),
              ],
            ),
            30.height,
            Text("You can earn more rewards by referring your friends to Pay. Semd then your refferal code", style: primaryTextStyle(size: 14, color: ColorBlack)),
            Text("(32y52b).", style: primaryTextStyle(size: 14, color: ColorBlack, weight: FontWeight.bold), textAlign: TextAlign.start),
          ],
        ),
      ),
    );
  }
}
