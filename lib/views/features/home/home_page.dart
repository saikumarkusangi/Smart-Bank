
import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/views/features/profile/profile_page.dart';
import 'package:bank/views/features/send/send_page.dart';
import 'package:bank/views/widgets/mic.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

import '../../../controllers/user_controller.dart';
import '../../widgets/action_box.dart';
import '../../widgets/avatar_image.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/credit_card.dart';
import '../../widgets/transaction_item.dart';
import '../history/history.dart';
import '../request/request.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  final translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    @override
    final userDataProvider = Provider.of<UserController>(context);
    // check();
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
              floatingActionButton: const Mic(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size(double.maxFinite, 80),
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.only(top: 10, right: 20, left: 10),
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                      color: ThemeColors.background,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeColors.shadowColor.withOpacity(0.1),
                            blurRadius: .5,
                            spreadRadius: .5,
                            offset: const Offset(0, 1))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Get.to(const ProfilePage()),
                        child: AvatarImage(Images.avatars[1],
                            isSVG: false, width: 35, height: 35),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerLeft,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Greetings.greetingText(),
                              style: const TextStyle(
                                  color: Colors.white60, fontSize: 18),
                            ),
                            Text(
                              userDataProvider.nickName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                             onTap: () async {
                                SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        if (prefs.getString('language') == 'en') {
                          var telugu = const Locale('te', 'IN');
                                Get.updateLocale(telugu);
                    prefs.setString('language', 'te');
                        } else {
                          var english = const Locale('en', 'IN');
                                Get.updateLocale(english);
                    prefs.setString('language', 'en');
                        }
                        
                             },
                              child: const Icon(Icons.translate))
                          // child: badge(
                          //   padding: const EdgeInsets.all(3),
                          //   position: badge.BadgePosition.topEnd(top: -5, end: 2),
                          //   badgeContent: Text('', style: TextStyle(color: Colors.white),),
                          //   child: Icon(Icons.notifications_rounded)
                          // ),
                          ),
                    ],
                  ),
                ),
              ),
              body: getBody()),
        ),
      ],
    );
  }

  getBody() {
    final userDataProvider = Provider.of<UserController>(context);
    return Consumer<UserController>(
      builder: (context, value, child) => RefreshIndicator(
        onRefresh: () async {
          await value.transactions(nickName: userDataProvider.nickName.trim());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: (!value.balance)
                            ? const CreditCard()
                            : const BalanceCard()),
                    const SizedBox(
                      height: 35,
                    ),
                    getActions(),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 15),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transactions".tr,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            const Icon(Icons.expand_more_rounded),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                          children: List.generate(
                              (value.history.length > 5)
                                  ? 5
                                  : value.history.length,
                              (index) => Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  child:
                                      TransactionItem(value.history[index])))),
                    ),
                    (value.history.length > 5)
                        ? Padding(
                            padding: const EdgeInsets.all(15),
                            child: InkWell(
                              onTap: () => Get.to(const History(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(milliseconds: 200)),
                              child: Text(
                                'See More'.tr,
                                style:
                                    const TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Image.asset(
                        'assets/images/cities.png',
                        fit: BoxFit.fitWidth,
                      )))
            ],
          ),
        ),
      ),
    );
  }

  getActions() {
    final pinController = TextEditingController();

    final pinProvider = Provider.of<UserController>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
                onTap: () => Get.to(const SendPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 200)),
                child: ActionBox(
                  title: "Send".tr,
                  icon: Icons.send_rounded,
                  bgColor: ThemeColors.green,
                ))),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
          onTap: () => Get.to(const RequestPage(),
              transition: Transition.cupertino,
              duration: const Duration(milliseconds: 200)),
          child: ActionBox(
              title: "Request".tr,
              icon: Icons.arrow_circle_down_rounded,
              bgColor: ThemeColors.yellow),
        )),
        const SizedBox(
          width: 15,
        ),
        Expanded(
            child: InkWell(
          onTap: () {

            showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      color: ThemeColors.background,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enter Your Pin".tr,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 28),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Pinput(
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
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(color: Colors.white),
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
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                final amount = Provider.of<UserController>(
                                    context,
                                    listen: false);

                                if (pinController.text ==
                                    pinProvider.pinNumber.trim()) {
                                  if (amount.balance) {
                                    amount.showBalance(false);
                                    Navigator.pop(context);
                                  } else {
                                    SpeechController.listen(
                                        "${"your account balance is ruppess".tr}${amount.currentBalance}");

                                    amount.showBalance(true);
                                    Navigator.pop(context);
                                  }
                                } else {
                                  SpeechController.listen(
                                      "please check your pin".tr);
                                  Get.snackbar('please check your pin'.tr,
                                      'please check your pin'.tr);
                                }
                              },
                              child: Chip(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                label: Text('Login'.tr),
                                labelStyle: const TextStyle(
                                    color: ThemeColors.background,
                                    fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: ActionBox(
              title: "Balance".tr,
              icon: Icons.account_balance_wallet_rounded,
              bgColor: ThemeColors.purple),
        )),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
