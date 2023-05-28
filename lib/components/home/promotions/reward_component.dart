import 'package:bank/models/models.dart';
import 'package:bank/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:scratcher/scratcher.dart';

import '../../../views/views.dart';
import '../../components.dart';

class RewardComponent extends StatefulWidget {
  static String tag = '/RewardComponent';

  const RewardComponent({super.key});

  @override
  RewardComponentState createState() => RewardComponentState();
}

class RewardComponentState extends State<RewardComponent> {
  List<RewardAmountModel> rewardDataList = getRewardAmount();
  bool threshold = false;
  String? rewardAmount;
  ScrollController scrollController = ScrollController();
  bool isAppbarChange = false;
  int newAmount = 0;
  var totalAmount = 0;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColor,
        title: Text(
                totalAmount != null ? '${'\u20B9'} $totalAmount' : "\u20B9 0",
                style: primaryTextStyle(
                    size: 18, color: ColorBlack, weight: FontWeight.bold))
            .visible(isAppbarChange),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: backgroundColor),
            onSelected: (dynamic v) {
              toast('Click');
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];
              list.add(
                const PopupMenuItem(
                    value: 1,
                    child: Text("Send Feedback",
                        style: TextStyle(color: ColorBlack))),
              );
              return list;
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(rewardbg), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    totalAmount != null
                        ? '${'\u20B9'} $totalAmount'
                        : "\u20B9 0",
                    style: primaryTextStyle(
                        size: 30, color: ColorBlack, weight: FontWeight.bold)),
                5.height,
                Text("Total rewards".tr,
                    style: primaryTextStyle(size: 20, color: ColorBlack))
              ],
            ).paddingLeft(16),
          ),
          ListView(
            shrinkWrap: true,
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 200),
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: radiusOnly(topRight: 14, topLeft: 14),
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor)),
                child: GridView.builder(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 16, right: 16),
                  scrollDirection: Axis.vertical,
                  itemCount: rewardDataList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 1.0),
                  itemBuilder: (context, index) {
                    RewardAmountModel mData = rewardDataList[index];

                    return GestureDetector(
                      onTap: () async {
                        bool? res = await scratchCardDialog(context, mData);
                        mData.isScratch = res ?? false;

                        if (mData.rewardAmount.isDigit()) {
                          rewardAmount = mData.rewardAmount;
                          newAmount = int.parse(rewardAmount!);
                          totalAmount += int.parse(rewardAmount!);
                        }
                        setState(() {});
                      },
                      child: ScratchWidget(mData: mData),
                    );
                  },
                ),
              ),
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
            currentRoute: '/RewardsPage',
          ));
        },
      ).paddingOnly(bottom: 16),
    );
  }
}

class ScratchWidget extends StatelessWidget {
  const ScratchWidget({
    Key? key,
    required this.mData,
  }) : super(key: key);

  final RewardAmountModel mData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: backgroundColor,
            boxShadow: [],
            borderRadius: radius(10),
          ),
          height: 300,
          width: 300,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mData.rewardAmount!,
                  style: primaryTextStyle(
                      size: 24, color: AppColor, weight: FontWeight.bold)),
              Text(mData.description,
                  style: primaryTextStyle(size: 20, color: AppColor)),
            ],
          ),
        ),
        Image.asset(buynow, height: 300, width: 300, fit: BoxFit.cover)
            .visible(!mData.isScratch.validate()),
      ],
    );
  }
}

Future<bool?> scratchCardDialog(context, RewardAmountModel mData) async {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return SafeArea(
        child: Material(
          color: Colors.black12.withOpacity(0.4),
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close,
                        color: backgroundColor, size: 24),
                    onPressed: () {
                      finish(context);
                    },
                  ),
                ),
                StatefulBuilder(builder: (context, StateSetter setState) {
                  setState(() {});
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: Scratcher(
                      accuracy: ScratchAccuracy.low,
                      brushSize: 50,
                      threshold: 50,
                      color: Colors.transparent,
                      image: commonCacheImageWidget(rewardsquareimg,
                          fit: BoxFit.cover, height: 300, width: 300) as Image?,
                      onThreshold: () {
                        finish(context, true);
                      },
                      child: Container(
                        height: 300,
                        width: 300,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(mData.rewardAmount!,
                                style: primaryTextStyle(
                                    size: 24,
                                    color: AppColor,
                                    weight: FontWeight.bold)),
                            Text(mData.description,
                                style: primaryTextStyle(
                                    size: 20, color: AppColor)),
                          ],
                        ),
                      ),
                    ).cornerRadiusWithClipRRect(10),
                  );
                }),
                AppRaisedButton(
                  height: 45,
                  color: AppColor,
                  title: 'Tell your friends',
                  titleColor: Colors.white,
                  titleSize: 14,
                  onPressed: () {
                    toast('continue');
                  },
                  borderRadius: 25,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
