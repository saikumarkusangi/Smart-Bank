import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../controllers/controllers.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  QrScreenState createState() => QrScreenState();
}

class QrScreenState extends State<QrScreen> {
  var pageController = PageController();
  List<Widget> pages = [];
  var selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    pages = [qrScannerWidget(context)];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? backgroundColorDark : backgroundColor,
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.close,
                      color: Get.isDarkMode ? backgroundColor : blackColor),
                  onPressed: () {
                    finish(context);
                  },
                ).paddingLeft(12),
                DotIndicator(
                        pages: pages,
                        pageController: pageController,
                        indicatorColor: Colors.transparent)
                    .expand(),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert_outlined,
                      color: Get.isDarkMode ? backgroundColor : blackColor),
                  onSelected: (dynamic v) {},
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
            15.height,
            PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              children: pages,
              onPageChanged: (index) {
                selectedIndex = index;
                setState(() {});
              },
            ).expand(),
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
              currentRoute: '/QrPage',
            ));
          },
        ).paddingOnly(bottom: 16),
      ),
    );
  }
}

Widget qrScannerWidget(context) {
  final userDataProvider = Provider.of<UserController>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      50.height,
      Text("Scan my code to pay",
          style: Theme.of(context).textTheme.headlineMedium),
      50.height,
      QrImageView(
        backgroundColor: Colors.white,
        data: userDataProvider.nickName,
        version: QrVersions.auto,
        size: 280.0,
      ),
      // commonCacheImageWidget(qrscannerimgbig,
      //     height: 280, width: 280, fit: BoxFit.fill),

      30.height,
      Text('${'nick name'.tr} : ${userDataProvider.nickName}',
          style: Theme.of(context).textTheme.bodySmall),
      15.height,
      Text('${'Upi id'.tr} : ${userDataProvider.upiId}',
          style: Theme.of(context).textTheme.bodySmall),
      30.height,
      TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.grey[300]!)),
          backgroundColor: Colors.white,
          // textColor: Colors.grey,
          padding: const EdgeInsets.all(8),
        ),
        onPressed: () {
          QrScannerScreen(
            screenName: 'qrpage',
          ).launch(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, color: grey),
            Text("Open scanner",
                    style: primaryTextStyle(
                        color: grey, size: 14, weight: FontWeight.bold),
                    textAlign: TextAlign.center)
                .expand(),
          ],
        ),
      ).paddingOnly(left: 60, right: 60),
    ],
  );
}
