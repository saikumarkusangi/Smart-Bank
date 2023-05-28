import 'package:bank/models/models.dart';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../components.dart';

class OfferComponent extends StatefulWidget {
  static String tag = '/OfferComponent';

  const OfferComponent({super.key});

  @override
  OfferComponentState createState() => OfferComponentState();
}

class OfferComponentState extends State<OfferComponent> {
  List<OfferModel> offerList = getOfferData();
  String? image;
  String? amount;
  String? description;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Discover offers",
                style: primaryTextStyle(
                    color: backgroundColor, size: 16, weight: FontWeight.bold))
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: backgroundColor),
            onPressed: () async {
              await Share.share('share Link');
            },
          ),
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
                      style: TextStyle(color: ColorBlack)),
                ),
              );
              return list;
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CarouselSlider.builder(
                itemCount: offerList.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  autoPlay: false,
                  initialPage: 1,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  viewportFraction: 0.75,
                  aspectRatio: 2.0,
                  onPageChanged: (i, _) {
                    currentpage = i;
                    setState(() {});
                  },
                ),
                itemBuilder: (BuildContext context, int itemIndex, i) {
                  OfferModel mdata = offerList[itemIndex];
                  return Container(
                    padding: const EdgeInsets.only(),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child:
                              Image.asset(mdata.img, height: 250, width: 350),
                        ),
                        20.height,
                        Text(mdata.earnAmount,
                            style:
                                primaryTextStyle(size: 22, color: ColorBlack),
                            textAlign: TextAlign.center),
                        5.height,
                        Text(mdata.description,
                            style:
                                primaryTextStyle(size: 15, color: ColorBlack),
                            textAlign: TextAlign.center),
                        const Spacer(),
                        Text("From SMART BANK".toUpperCase(),
                            style: secondaryTextStyle(
                                size: 10, color: ColorBlack)),
                        5.height,
                        Text("Offer expires 31 December 2020".toUpperCase(),
                            style:
                                secondaryTextStyle(size: 10, color: ColorBlack))
                      ],
                    ).paddingTop(12),
                  ).onTap(() {
                    OfferDetailsComponent(
                            image: offerList[itemIndex].img,
                            amount: offerList[itemIndex].earnAmount,
                            description: offerList[itemIndex].description)
                        .launch(context);
                  });
                }),
          ),
          Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                      color: AppColor,
                      border: Border.all(color: AppColor),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Text("See offer details",
                      style:
                          primaryTextStyle(color: backgroundColor, size: 14)))
              .onTap(() {
            OfferDetailsComponent(
                    image: offerList[currentpage].img,
                    amount: offerList[currentpage].earnAmount,
                    description: offerList[currentpage].description)
                .launch(context);
          })
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
            currentRoute: '/OffersPage',
          ));
        },
      ).paddingOnly(bottom: 16),
    );
  }
}
