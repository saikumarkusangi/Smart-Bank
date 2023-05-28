// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import '../../models/models.dart';
// import '../../utils/utils.dart';

// class BusinessSubListComponent extends StatefulWidget {
//   static String tag = '/BusinessSubListComponent';

//   const BusinessSubListComponent({super.key});

//   @override
//   BusinessSubListComponentState createState() => BusinessSubListComponentState();
// }

// class BusinessSubListComponentState extends State<BusinessSubListComponent> {
//  // List<BusinessSublistModel> getBusinessTravelModel = getBusinessTravelList();


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!),
//        borderRadius: const BorderRadius.all(Radius.circular(15))),
//       child: ListView.builder(
//         padding: const EdgeInsets.all(20),
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemCount: getBusinessTravelModel.length,
//         itemBuilder: (context, index) {
//           BusinessSublistModel mData = getBusinessTravelModel[index];
//           return Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(radius: 22, backgroundColor: black, backgroundImage: AssetImage(mData.image)),
//               10.width,
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(mData.name, style: primaryTextStyle(size: 14, color: ColorBlack)),
//                   Text(mData.description, style: secondaryTextStyle(size: 13, color: ColorBlack)),
//                 ],
//               ).expand(),
//               Text(mData.buttonTitle, style: primaryTextStyle(color: AppColor, size: 14, weight: FontWeight.bold))
//             ],
//           ).paddingOnly(top: 12, bottom: 12);
//         },
//       ),
//     ).paddingOnly(top: 10, left: 16, right: 16);
//   }
// }
