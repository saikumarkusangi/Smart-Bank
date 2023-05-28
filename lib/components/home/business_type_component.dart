import 'package:bank/models/smartbank_model.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/views/features/explore/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BusinessTypeList extends StatefulWidget {
  static String tag = '/BusinessTypeList';
  List<BusinessTypeModel>? getBusinessTypeList;

  BusinessTypeList({super.key, this.getBusinessTypeList});

  @override
  BusinessTypeListState createState() => BusinessTypeListState();
}

class BusinessTypeListState extends State<BusinessTypeList> {
  int? tabIndex;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    tabIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      scrollDirection: Axis.horizontal,
      itemCount: widget.getBusinessTypeList!.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        BusinessTypeModel mData = widget.getBusinessTypeList![index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              mData.businessImg,
                 const SizedBox(width:10,),
              Text(mData.businessName,
                  style: primaryTextStyle(size: 14, color: ColorBlack))
            ],
          ).paddingOnly(left: 10, right: 10),
        ).paddingOnly(left: 5, right: 5);
      },
    ).onTap(() {
      const ExploreScreen().launch(context);
    });
  }
}
