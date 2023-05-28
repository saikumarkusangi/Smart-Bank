import 'package:bank/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/utils.dart';
import '../components.dart';

class BusinessesComponent extends StatefulWidget {
  static String tag = '/BusinessesComponent';

  const BusinessesComponent({super.key});

  @override
  BusinessesComponentState createState() => BusinessesComponentState();
}

class BusinessesComponentState extends State<BusinessesComponent> {
  List<PopularBusinessModel>? getPopularBusinessData;
  List<BusinessSublistModel>? getBusinessTravelModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget("Popular"),
            16.height,
            getBusinessListWidget(getPopularBusinessModel()),
            16.height,
            businessSubListComponent(getBusinessTravelList()),
            16.height,
            titleWidget("Food", isNext: true),
            16.height,
            getBusinessListWidget(getFoodBusinessModel()),
            16.height,
            businessSubListComponent(getBusinessFoodList()),
          ],
        )
      ],
    );
  }

  Widget titleWidget(String title, {bool isNext = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: primaryTextStyle(
              size: 24, color: Get.isDarkMode ? Colors.white :Colors.black, weight: FontWeight.bold),
        ),
        isNext
            ? CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 16,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.navigate_next_outlined),
                  color: Colors.black,
                  onPressed: () {},
                ),
              )
            : Container()
      ],
    ).paddingOnly(left: 20, right: 20);
  }

  Widget getBusinessListWidget(List<PopularBusinessModel> list) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          PopularBusinessModel mData = list[index];
          return Column(
            children: [
              SizedBox(
                width: 320,
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: ExactAssetImage(mData.image)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(mData.title,
                            style: primaryTextStyle(
                                size: 20, color: backgroundColor),
                            textAlign: TextAlign.start),
                        5.height,
                        Text(mData.offer,
                            style: primaryTextStyle(
                                size: 12, color: backgroundColor)),
                        20.height,
                        OutlinedButton(
                            onPressed: () {
                              const BusinessBuyNowComponent().launch(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side:
                                  const BorderSide(color: backgroundColor, width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            child: Text("Buy now",
                                style: primaryTextStyle(
                                    color: backgroundColor, size: 14)))
                      ],
                    ).paddingOnly(left: 20, top: 30)
                  ],
                ).paddingOnly(left: 20, right: 12),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget businessSubListComponent(List<BusinessSublistModel> list) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          BusinessSublistModel mData = list[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                
                  radius: 22,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(mData.image)),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mData.name,
                      style: primaryTextStyle(size: 14, color: Get.isDarkMode ? Colors.white :Colors.black)),
                  Text(mData.description,
                      style: secondaryTextStyle(size: 13,color: Get.isDarkMode ? Colors.white :Colors.black)),
                ],
              ).expand(),
              Text(mData.buttonTitle,
                  style: primaryTextStyle(
                    color: Get.isDarkMode ? Colors.white :AppColor, size: 14, weight: FontWeight.bold))
            ],
          ).paddingOnly(top: 12, bottom: 12);
        },
      ),
    ).paddingOnly(top: 10, left: 20, right: 20);
  }
}
