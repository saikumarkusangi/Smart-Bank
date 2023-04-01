// import 'package:bank/constants/constants.dart';
// import 'package:bank/controllers/history_controller.dart';
// import 'package:bank/controllers/textFieldController/textfield_controller.dart.dart';
// import 'package:bank/controllers/user_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// import '../../../controllers/speech_controller.dart';
// import '../../views.dart';
// import '../../widgets/bottom_navigation_items.dart';
// import '../../widgets/mic.dart';
// import '../profile/profile_page.dart';

// class Home extends StatefulWidget {
//   Home({Key? key, required this.activeTab}) : super(key: key);
//   int activeTab;
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override

//   @override
//   Widget build(BuildContext context) {
//     setState(() {
      
//     });
//     final moneysend = Provider.of<TextFieldController>(context);
   

//     print(
//         '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@active tab = ${widget.activeTab}');
//     print(
//         '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@active tab = ${Get.currentRoute}');

//     return Container(
//       decoration: const BoxDecoration(
//         color: ThemeColors.appBgColor,
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40), topRight: Radius.circular(40)),
//       ),
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           bottomNavigationBar: getBottomBar(),
//           // floatingActionButton: getHomeButton(),
//           // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
//           body: getBarPage()),
//     );
//   }

//   // Widget getHomeButton(){
//   //   return const Positioned(
//   //     child: Mic());
//   // }

//   Widget getBottomBar() {
//     final provider = Provider.of<UserController>(context);
//     return Container(
//       height: 75,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: ThemeColors.bottomBarColor,
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(25), topRight: Radius.circular(25)),
//           boxShadow: [
//             BoxShadow(
//                 color: ThemeColors.shadowColor.withOpacity(0.1),
//                 blurRadius: .5,
//                 spreadRadius: .5,
//                 offset: const Offset(0, 1))
//           ]),
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
//           child: BottomBarItem(
//             Icons.home_rounded,
//             "",
//             isActive: widget.activeTab == 0,
//             activeColor: ThemeColors.primary,
//             onTap: () {
//               setState(() {
//                 widget.activeTab = 0;
//               });
//             },
//           ),
//         ),
//         const Mic(),
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 25, top: 15),
//           child: BottomBarItem(
//             Icons.person_rounded,
//             "",
//             isActive: widget.activeTab == 1,
//             activeColor: ThemeColors.primary,
//             onTap: () async {
//               setState(() {
//                 widget.activeTab = 1;
//               });
//               await SpeechController.listen("your personal details are".tr);
//               await SpeechController.listen("Nick Name ${provider.nickName}");
//               await SpeechController.listen("User Name ${provider.userName}");
//               await SpeechController.listen("Full Name ${provider.fullName}");
//               await SpeechController.listen(
//                   "Mobile Number ${provider.phoneNumber}");
//               await SpeechController.listen("Upi id ${provider.upiId}");
//             },
//           ),
//         ),
//       ]),
//     );
//   }

//   Widget getBarPage() {
//     return IndexedStack(
//       index: widget.activeTab,
//       children: const <Widget>[HomePage(), ProfilePage()],
//     );
//   }
// }
