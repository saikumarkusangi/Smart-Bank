import 'dart:async';
import 'dart:io';
import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/telugu_data_controller.dart';
import 'package:bank/utils/utils.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
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

  play() async {
    final teluguDataProvider = Provider.of<TeluguDataController>(context);
    final userDataProvider = Provider.of<UserController>(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('language') == 'en') {
      Timer(Duration.zero, () async {
        if (mounted) {
          await TtsApi.api('your nick name  ${userDataProvider.nickName}');
        }
      });
      Timer(const Duration(seconds: 3), () async {
        if (mounted) {
          await TtsApi.api('your user name ${userDataProvider.userName}');
        }
      });
      Timer(const Duration(seconds: 6), () async {
        if (mounted) {
          await TtsApi.api('your full name ${userDataProvider.fullName}');
        }
      });
      Timer(const Duration(seconds: 9), () async {
        if (mounted) {
          await TtsApi.api('your u p i  i d ${userDataProvider.upiId}');
        }
      });
      Timer(const Duration(seconds: 12), () async {
        if (mounted) {
          await TtsApi.api(
              'your mobile number ${userDataProvider.phoneNumber}');
        }
      });
    } else {
      Timer(Duration.zero, () {
        if (mounted) {
          TtsApi.api('మీ మారుపేరు ${teluguDataProvider.nickname}');
        }
      });
      Timer(const Duration(seconds: 3), () async {
        if (mounted) {
          await TtsApi.api(
              'మీ వినియోగదారు పేరు ${teluguDataProvider.username}');
        }
      });
      Timer(const Duration(seconds: 6), () async {
        if (mounted) {
          await TtsApi.api('మీ పూర్తి పేరు ${teluguDataProvider.fullname}');
        }
      });
      Timer(const Duration(seconds: 9), () async {
        if (mounted) {
          await TtsApi.api('మీ యు పి ఐ ఐ డి ${teluguDataProvider.upiid}');
        }
      });
      Timer(const Duration(seconds: 12), () async {
        if (mounted) {
          await TtsApi.api('మీ మొబైల్ నంబర్ ${teluguDataProvider.mobile}');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    play();
    //   await TtsApi.api('మీ మారుపేరు ${userDataProvider.nickName}');

    // Timer(const Duration(seconds: 3), () async {
    //   if (mounted) {
    //     await TtsApi.api('మీ పూర్తి పేరు ${userDataProvider.fullName}');
    //   }
    // });
    // Timer(const Duration(seconds: 6), () async {
    //   if (mounted) {
    //     await TtsApi.api('మీ యు పి ఐ ఐ డి ${userDataProvider.upiId}');
    //   }
    // });
    // Timer(const Duration(seconds: 8), () async {
    //   if (mounted) {
    //     await TtsApi.api('మీ మొబైల్ నంబర్ ${userDataProvider.phoneNumber}');
    //   }
    // });

    final provider = Provider.of<UserController>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text("Profile".tr,
              style: primaryTextStyle(size: 18, color: backgroundColor)),
          key: scaffoldKey,
          elevation: 0,
          backgroundColor: AppColor,
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
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  profileImage!,
                                ))
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  profileImage != null
                                      ? profileImage as String
                                      : user,
                                )),
                        Positioned(
                          bottom: 20,
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
                Divider(color: Colors.grey[300], thickness: 1),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PERSONAL DETAILS".tr,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(phoneicon, "Nick name".tr,
                            provider.nickName, 'nickname'),
                        IconButton(
                            onPressed: () => updatedialog(
                                context,
                                'Enter new nick name'.tr,
                                'nick_name',
                                provider.nickName),
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Get.isDarkMode ? Colors.white : AppColor,
                            ))
                      ],
                    ),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(phoneicon, "User name".tr,
                            provider.userName, 'username'),
                        IconButton(
                            onPressed: () => updatedialog(
                                context,
                                'Enter new user name'.tr,
                                'user_name',
                                provider.nickName),
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Get.isDarkMode ? Colors.white : AppColor,
                            ))
                      ],
                    ),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(phoneicon, "Full name".tr,
                            provider.fullName, 'fullname'),
                        IconButton(
                            onPressed: () => updatedialog(
                                context,
                                'Enter new full name'.tr,
                                'full_name',
                                provider.nickName),
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Get.isDarkMode ? Colors.white : AppColor,
                            ))
                      ],
                    ),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(
                            phoneicon, "UPI ID".tr, provider.upiId, 'upi id'),
                        IconButton(
                            onPressed: () => updatedialog(
                                context,
                                'Enter new UPI ID'.tr,
                                'upi_id',
                                provider.nickName),
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Get.isDarkMode ? Colors.white : AppColor,
                            ))
                      ],
                    ),
                    24.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        accountWidget(phoneicon, "Mobile number".tr,
                            provider.phoneNumber, 'mobile'),
                        IconButton(
                            onPressed: () => updatedialog(
                                context,
                                'Enter new mobile  number'.tr,
                                'mobile_number',
                                provider.nickName),
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Get.isDarkMode ? Colors.white : AppColor,
                            ))
                      ],
                    ),
                    24.height,
                    PopupMenuButton(
                      child: accountWidget(
                          languageicon,
                          "Language".tr,
                          prefs.getString('language') == 'en'
                              ? 'English'
                              : 'తెలుగు',
                          'language'),
                      onSelected: (dynamic v) {
                        toast("Language changed".tr);
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
                        accountWidget(themeImage, "App Theme".tr,
                            toogle ? "Dark mode" : "Light mode", 'theme'),
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
                      Text("PRIVACY AND SECURITY".tr.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineMedium),
                      24.height,
                      accountWidget(privacyicon, "Privacy".tr,
                          "Sharing and visibility".tr, 'privacy'),
                      24.height,
                      accountWidget(notification, "Notifications".tr,
                          "Turn notifications on/off".tr, 'notifications'),
                      24.height,
                      accountWidget(securityicon, "Security".tr, "* * * * * *",
                          'security'),
                      24.height,
                      InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            try {
                              //  await TtsApi.api('you have logged out'.tr);
                              provider.clearData();
                              prefs.setString('Nick name', '');
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
                          child: accountWidget(logout, "Log out".tr,
                              "Log out from Smart Bank".tr, 'logout')),
                      24.height,
                      InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            try {
                              NetworkServices.deleteUser(
                                  prefs.getString('Nick name')!);
                              await TtsApi.api(
                                  'your account has been deleted'.tr);
                              provider.clearData();
                              prefs.setString('Nick name', '');
                              prefs.setString('pin', '');
                              prefs.setBool('user', false);
                              Get.off(LoginPage());
                              Get.snackbar(
                                  backgroundColor: Colors.white,
                                  'success'.tr,
                                  'your account has been deleted'.tr);
                            } catch (e) {
                              rethrow;
                            }
                          },
                          child: accountWidget(
                              logouticon,
                              "Close account".tr,
                              "Delete Smart Bank Account Permanently".tr,
                              'close'.tr)),
                    ],
                  ).paddingOnly(left: 20, right: 20, top: 10, bottom: 10),
                ),
                Divider(color: Colors.grey[300], thickness: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("INFORMATION".tr,
                        style: Theme.of(context).textTheme.headlineMedium),
                    24.height,
                    informationWidget(helpicon, "Help & feedback".tr),
                    24.height,
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (c, snap) {
                        return informationWidget(
                            versionicon,
                            "Developed by : Sai Kumar\n Kusangi and Sravika Malipeddi"
                                .tr);
                      },
                    ),
                  ],
                ).paddingOnly(left: 20, right: 20, top: 10, bottom: 80),
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

  Widget accountWidget(
      String image, String title, String phoneNumber, String tag) {
    final teluguDataProvider = Provider.of<TeluguDataController>(context);
    return FutureBuilder(
        future: trans(phoneNumber),
        builder: (context, snap) {
          if (snap.hasData) {
            if (tag == 'nickname') {
              teluguDataProvider.changenick(snap.data);
            } else if (tag == 'username') {
              teluguDataProvider.changeuser(snap.data);
            } else if (tag == 'fullname') {
              teluguDataProvider.changefull(snap.data);
            } else if (tag == 'mobile') {
              teluguDataProvider.changemobile(snap.data);
            } else if (tag == 'upiid') {
              teluguDataProvider.chnageupi(snap.data);
            }

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

  updatedialog(dialogContext, hinttext, key, nickname) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        barrierDismissible: true,
        context: dialogContext,
        builder: (context) {
          return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    NetworkServices.update(key, controller.text, nickname);
                    Get.back();
                  },
                  child: Text('Update'.tr),
                )
              ],
              title: Text('Update'.tr,
                  style: primaryTextStyle(
                      color: ColorBlack, size: 20, weight: FontWeight.bold),
                  textAlign: TextAlign.start),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: hinttext),
                    )
                  ]));
        });
  }

  dialogWidget(dialogContext) {
    return showDialog(
      barrierDismissible: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Set profile photo'.tr,
              style: primaryTextStyle(
                  color: ColorBlack, size: 20, weight: FontWeight.bold),
              textAlign: TextAlign.start),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Take photo'.tr,
                      style: primaryTextStyle(size: 16, color: ColorBlack))
                  .onTap(() {
                pickFromCamera();
                finish(context);
              }),
              20.height,
              Text('Choose photo'.tr,
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
