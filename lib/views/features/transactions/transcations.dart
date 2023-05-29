import 'dart:async';

import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../controllers/controllers.dart';
import '../../views.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  bool lo = false;
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserController>(context);

    return Scaffold(
      backgroundColor: Get.isDarkMode ? backgroundColorDark : backgroundColor,
      appBar: AppBar(
        title: Text(
          'All transactions'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        backgroundColor: AppColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Consumer<UserController>(builder: (context, value, child) {
            if (value.history.isNotEmpty == false) {
              Future.delayed(Duration.zero, () async {
                setState(() {});
              });
            }
            return RefreshIndicator(
                onRefresh: () async {
                  await userDataProvider.clearHistory();
                },
                child: value.history.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: value.history.length >= 10
                            ? 10
                            : value.history.length,
                        itemBuilder: (context, index) {
                          return TransactionItem(value.history[index]);
                        })
                    : const Center(
                        child: CircularProgressIndicator(),
                      ));
          }),
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
            const Icon(Icons.mic, color: Colors.white, size: 26),
            5.width,
            Text('Tap to speak'.tr,
                style: primaryTextStyle(size: 16, color: Colors.white))
          ],
        ),
        onPressed: () {
          Get.to(Mic(
            currentRoute: '/loginPage',
          ));
          // ExploreScreen().launch(context);
        },
      ).paddingOnly(bottom: 16),
    );
  }
}
