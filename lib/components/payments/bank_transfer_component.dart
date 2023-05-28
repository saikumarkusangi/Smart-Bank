import 'package:bank/components/components.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/utils.dart';

class BankTransferComponent extends StatefulWidget {
  static String tag = '/BankTransferComponent';

  const BankTransferComponent({super.key});

  @override
  BankTransferComponentState createState() => BankTransferComponentState();
}

class BankTransferComponentState extends State<BankTransferComponent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController reenterAccountController = TextEditingController();
  TextEditingController iFSCController = TextEditingController();
  TextEditingController recipientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: backgroundColor),
        backgroundColor: AppColor,
        elevation: 2,
        automaticallyImplyLeading: true,
        title: Text("Enter Bank Details",
            style: primaryTextStyle(color: backgroundColor)),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onSelected: (dynamic v) {
              toast('Click');
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(
                const PopupMenuItem(
                    value: 1,
                    child: Text("Send feedback",
                        style: TextStyle(color: ColorBlack))),
              );
              return list;
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 30, right: 20, left: 20, bottom: 16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: accountNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        labelText: "Account Number",
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorBlack)),
                      ),
                      maxLines: 1,
                    ),
                    35.height,
                    TextFormField(
                      controller: reenterAccountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        labelText: "Re-enter account number",
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorBlack)),
                      ),
                      maxLines: 1,
                    ),
                    35.height,
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Search for IFSC",
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    TextFormField(
                      controller: iFSCController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        labelText: "IFSC",
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorBlack)),
                      ),
                      maxLines: 1,
                    ),
                    35.height,
                    TextFormField(
                      controller: iFSCController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        labelText: "Recipient name",
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorBlack)),
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 150,
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "This information will be securely saved as per the Rp Bank Terms of Services and Privacy Policy.",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ).paddingOnly(left: 20, right: 20),
                    20.height,
                    AppRaisedButton(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: AppColor,
                      title: 'Continue',
                      titleColor: Colors.white,
                      titleSize: 14,
                      onPressed: () {
                        toast('coming soon');
                      },
                      borderRadius: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
            currentRoute: '/BankTransferPage',
          ));
        },
      ).paddingOnly(bottom: 16),
    );
  }
}
