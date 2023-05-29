import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:bank/models/models.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/images.dart';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/features/home/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:scratcher/scratcher.dart';

import '../../components/components.dart';

class PaidSucessScreen extends StatefulWidget {
  const PaidSucessScreen({super.key});

  @override
  State<PaidSucessScreen> createState() => _PaidSucessScreenState();
}

class _PaidSucessScreenState extends State<PaidSucessScreen> {
  AudioPlayer player = AudioPlayer();

  void play() async {
    const audio = 'audios/sucess.mp3';
    await player.play(AssetSource(audio));
  }

  Random rand = Random();
  List rewards = [1, 10, 5, 25, 6, 0];
  @override
  Widget build(BuildContext context) {
    play();
    return Scaffold(
      backgroundColor: AppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(sucessgif),
          const SizedBox(
            height: 50,
          ),
          Text(
            'Payment successful'.tr,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(
            height: 50,
          ),
          ActionChip(
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.normal),
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            label: Text('Done'.tr),
            onPressed: () {
              scratchCardDialog(context, rewards[rand.nextInt(5)]);
            },
          )
        ],
      ),
    );
  }
}

Future<bool?> scratchCardDialog(context, ammount) async {
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.all(0.0),
                      content: Scratcher(
                        accuracy: ScratchAccuracy.low,
                        brushSize: 50,
                        threshold: 50,
                        color: Colors.transparent,
                        image: commonCacheImageWidget(rewardsquareimg,
                            fit: BoxFit.cover,
                            height: 300,
                            width: 300) as Image?,
                        onThreshold: () {
                          RewardReveal(ammount: ammount).launch(context);
                          Timer(const Duration(seconds: 5), () {
                            Get.off(const MainScreen());
                          });
                        },
                        child: Container(
                          height: 300,
                          width: 300,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  ammount == 0
                                      ? 'Better Luck Next Time!'
                                      : '₹$ammount',
                                  style: primaryTextStyle(
                                      size: 32,
                                      color: AppColor,
                                      weight: FontWeight.bold)),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                  ammount == 0
                                      ? 'Oops!! try next time '.tr
                                      : 'You Earned Cashback'.tr,
                                  style: primaryTextStyle(
                                      size: 20, color: AppColor)),
                            ],
                          ),
                        ),
                      ).cornerRadiusWithClipRRect(10),
                    ),
                  );
                }),
                const SizedBox(
                  height: 15,
                ),
                Text("Scratch the above card for your reward".tr,
                    style: primaryTextStyle(size: 16, color: backgroundColor)),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class RewardReveal extends StatelessWidget {
  const RewardReveal({super.key, required this.ammount});
  
  final int ammount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Padding(
          padding: const EdgeInsets.only(left: 20),
        child: Container(
          color: Colors.white,
          height: 300,
          width: 300,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ammount == 0 ? 'Better Luck Next Time!' : '₹$ammount',
                  style: primaryTextStyle(
                      size: 32, color: AppColor, weight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text(
                  ammount == 0
                      ? 'Oops!! try next time'.tr
                      : 'You Earned Cashback'.tr,
                  style: primaryTextStyle(size: 20, color: AppColor)),
            ],
          ),
        ).cornerRadiusWithClipRRect(10),
      ).animate().shimmer(duration: 3000.ms,color: Colors.grey[400]),
    ]));
  }
}
