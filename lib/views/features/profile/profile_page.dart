import 'dart:async';
import 'dart:io';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import '../../../controllers/controllers.dart';
import '../../../services/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  File? profileImage;

  final telugu = const Locale('te', 'IN');
  final english = const Locale('en', 'IN');
  bool appTheme = false;
  String themeImage = 'assets/images/lightmodeimage.png';
  late SharedPreferences prefs;
  bool toogle = false;
  @override
  void initState() {
    super.initState();
    sharedpref();
    readout();
  }

  GoogleTranslator translator = GoogleTranslator();

  Future<String> trans(msg) {
    return translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) {
      return value.text.toString();
    });
  }

  sharedpref() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      appTheme = prefs.getBool('apptheme') ?? false;
    });
  }

  readout() async {
    await TtsApi.api('your name is a big name so plase');
    await TtsApi.api('your nick name sai');
  }

  read(data, msg) async {
    //await TtsApi.api("మీ పూర్తి పేరు $fullname");
    await TtsApi.api("మీ మారుపేరు $data");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserController>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text("Profile",
              style: primaryTextStyle(size: 18, color: backgroundColor)),
          key: scaffoldKey,
          elevation: 0,
          backgroundColor: AppColor,
          actions: [
            PopupMenuButton(
              icon:
                  const Icon(Icons.more_vert_outlined, color: backgroundColor),
              onSelected: (dynamic v) {},
              itemBuilder: (BuildContext context) {
                List<PopupMenuEntry<Object>> list = [];

                list.add(PopupMenuItem(
                    value: 1,
                    child: Text("Send feedback",
                        style: primaryTextStyle(color: ColorBlack))));
                return list;
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        profileImage != null
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                child: Image.file(profileImage!,
                                    fit: BoxFit.cover))
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage(
                                  profileImage != null
                                      ? profileImage as String
                                      : user,
                                )),
                        Positioned(
                          bottom: 10,
                          right: 20,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColor),
                            child: const Center(
                                child: Icon(Icons.camera_alt_outlined,
                                    color: backgroundColor, size: 22)),
                          ).onTap(() {
                            dialogWidget(context);
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(color: Colors.grey[300], thickness: 1),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personal Details".tr.toUpperCase(),
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(
                      height: 20,
                    ),
                    accountWidget(
                        nick, "nick name".tr.toUpperCase(), provider.nickName),
                    24.height,
                    accountWidget(user, "User Name".tr, provider.userName),
                    24.height,
                    accountWidget(full, "Full Name".tr, provider.fullName),
                    24.height,
                    accountWidget(
                        upi, "Upi id".tr.toUpperCase(), provider.upiId),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(
                            phoneicon,
                            "mobile number".tr.toUpperCase(),
                            provider.phoneNumber),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Get.isDarkMode ? Colors.white : AppColor,
                            ))
                      ],
                    ),
                    24.height,
                    accountWidget(
                            paymentmethodicon, "Payment methods".tr, "Rp Bank")
                        .onTap(() {
                      const PaymentMethodComponent().launch(context);
                    }),
                    24.height,
                    PopupMenuButton(
                      child: accountWidget(
                          languageicon,
                          "Language",
                          prefs.getString('language') == 'English'
                              ? 'English'
                              : 'తెలుగు'),
                      onSelected: (dynamic v) {
                        toast("Language Changed");
                      },
                      itemBuilder: (BuildContext context) {
                        List<PopupMenuEntry<Object>> list = [];

                        list.add(
                          PopupMenuItem(
                              onTap: () {
                                Get.updateLocale(english);
                                prefs.setString('language', 'en');
                              },
                              value: 1,
                              child: const Text("English",
                                  style: TextStyle(color: ColorBlack))),
                        );
                        list.add(
                          PopupMenuItem(
                              onTap: () {
                                Get.updateLocale(telugu);
                                prefs.setString('language', 'te');
                              },
                              value: 2,
                              child: const Text("తెలుగు",
                                  style: TextStyle(color: ColorBlack))),
                        );
                        return list;
                      },
                    ),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(themeImage, "App Theme",
                            toogle ? "Dark Mode" : "Light Mode"),
                        Switch(
                          value: appTheme,
                          onChanged: (value) async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('apptheme', value);
                            setState(() {
                              toogle = value;
                              appTheme = value;
                              toogle
                                  ? themeImage =
                                      'assets/images/darkmodeimage.png'
                                  : themeImage =
                                      'assets/images/lightmodeimage.png';
                            });
                            appTheme
                                ? Get.changeThemeMode(ThemeMode.dark)
                                : Get.changeThemeMode(ThemeMode.light);
                          },
                          activeTrackColor: Colors.blue[100],
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ).paddingOnly(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                Divider(color: Colors.grey[300], thickness: 1),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Privacy and security".toUpperCase(),
                          style: Theme.of(context).textTheme.headlineMedium),
                      24.height,
                      accountWidget(
                          privacyicon, "Privacy", "Sharing and visibility"),
                      24.height,
                      accountWidget(notification, "Notifications",
                          "Turn notifications on/off"),
                      24.height,
                      accountWidget(securityicon, "Security", "* * * * * *"),
                      24.height,
                      InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            try {
                              //  await TtsApi.api('you have logged out'.tr);
                              provider.clearData();
                              prefs.setString('nickName', '');
                              prefs.setString('pin', '');
                              prefs.setBool('user', false);
                              Get.off(LoginPage());
                              Get.snackbar(
                                  backgroundColor: Colors.white,
                                  'success'.tr,
                                  'you have logged out'.tr);
                            } catch (e) {
                              rethrow;
                            }
                          },
                          child: accountWidget(
                              logout, "Log out", "Log out from Smart Bank")),
                      24.height,
                      accountWidget(logouticon, "Close account",
                          "Delete Smart Bank Account Permanently"),
                    ],
                  ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),
                ),
                Divider(color: Colors.grey[300], thickness: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Information".toUpperCase(),
                        style: Theme.of(context).textTheme.headlineMedium),
                    24.height,
                    informationWidget(helpicon, "Help & feedback"),
                    24.height,
                    informationWidget(privacyicon, "Terms & privacy policy"),
                    24.height,
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (c, snap) {
                        return informationWidget(versionicon,
                            "Version ${snap.hasData ? snap.data!.version : ''}");
                      },
                    ),
                  ],
                ).paddingOnly(left: 20, right: 20, top: 10, bottom: 20),
              ],
            ),
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
              currentRoute: '/ProfilePage',
            ));
          },
        ).paddingOnly(bottom: 16),
      ),
    );
  }

  Widget accountWidget(String image, String title, String phoneNumber) {
    return FutureBuilder(
        future: trans(phoneNumber),
        builder: (context, snap) {
          if (snap.hasData) {
            return Column(
              children: [
                Row(
                  children: [
                    commonCacheImageWidget(image,
                        height: 18, width: 18, fit: BoxFit.fill),
                    16.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(snap.data!.isNotEmpty ? snap.data! : phoneNumber,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    )
                  ],
                ),
              ],
            );
          }
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[100],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    color: Colors.grey[100],
                    width: 100,
                    height: 15,
                  ),
                ],
              ));
        });
  }

  Widget informationWidget(String image, String title) {
    return Row(
      children: [
        commonCacheImageWidget(image, height: 18, width: 18, fit: BoxFit.fill),
        16.width,
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  dialogWidget(dialogContext) {
    return showDialog(
      barrierDismissible: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Set profile photo',
              style: primaryTextStyle(
                  color: ColorBlack, size: 20, weight: FontWeight.bold),
              textAlign: TextAlign.start),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Take photo',
                      style: primaryTextStyle(size: 16, color: ColorBlack))
                  .onTap(() {
                pickFromCamera();
                finish(context);
              }),
              20.height,
              Text('Choose photo',
                      style: primaryTextStyle(size: 16, color: ColorBlack))
                  .onTap(() {
                pickFromGallery();
                finish(context);
              }),
            ],
          ),
        );
      },
    );
  }

  pickFromCamera() async {
    File image = File((await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 100))!
        .path);
    setState(() {
      profileImage = image;
    });
  }

  pickFromGallery() async {
    File image = File((await ImagePicker()
            .getImage(source: ImageSource.gallery, imageQuality: 100))!
        .path);

    setState(() {
      profileImage = image;
    });
  }
}
