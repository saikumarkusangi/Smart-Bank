import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/views/features/transactions/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import '../../../utils/utils.dart';
import '../../views.dart';

class ToPerson extends StatefulWidget {
  String nickname;
  ToPerson({super.key, this.nickname = ''});

  @override
  ToPersonState createState() => ToPersonState();
}

class ToPersonState extends State<ToPerson> {
  bool isStopped = false;
  final searchController = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  Future<String> trans(msg) {
    return translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) {
      return value.text.toString();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rand = Random();
    if (widget.nickname.isNotEmpty) {
      searchController.text = widget.nickname;
    }
    if (widget.nickname.isNotEmpty) {
      List images = [
        'https://xsgames.co/randomusers/assets/avatars/male/${rand.nextInt(78)}.jpg',
        'https://xsgames.co/randomusers/assets/avatars/female/${rand.nextInt(78)}.jpg'
      ];
      Timer(Duration.zero, () {
        if (mounted) {
          Get.to(ChatScreen(
              nickname: searchController.text.trim(),
              image: images[rand.nextInt(2)],
              nicknameeng: searchController.text));
        }
      });
    }

    final userDataProvider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColor,
        elevation: 1,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: white),
            onSelected: (dynamic v) {
              toast('Click');
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];

              list.add(const PopupMenuItem(
                  value: 1,
                  child: Text("Refresh", style: TextStyle(color: ColorBlack))));
              list.add(const PopupMenuItem(
                  value: 1,
                  child: Text("Send feedback",
                      style: TextStyle(color: ColorBlack))));
              return list;
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onFieldSubmitted: (save) {
                  List images = [
                    'https://xsgames.co/randomusers/assets/avatars/male/${rand.nextInt(78)}.jpg',
                    'https://xsgames.co/randomusers/assets/avatars/female/${rand.nextInt(78)}.jpg'
                  ];
                  Get.to(ChatScreen(
                      nickname: searchController.text.trim(),
                      image: images[rand.nextInt(2)],
                      nicknameeng: searchController.text));
                },
                style: TextStyle(
                    fontSize: 18,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                controller: searchController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  floatingLabelStyle: const TextStyle(color: Colors.blue),
                  label:  Text('Enter recipient name'.tr),
                  fillColor: white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.grey[300]!)),
                  hintText: 'Enter recipient name'.tr,
                  hintStyle: secondaryTextStyle(
                      size: 18,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  prefixIcon: Icon(Icons.search,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                onTap: () {
                  //   hideKeyboard(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Recents'.tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              FutureBuilder(
                  future: userDataProvider.recentPeople(context),
                  builder: (BuildContext context, people) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: userDataProvider.recentPeopleList.length,
                        itemBuilder: (context, index) {
                          String person =
                              userDataProvider.recentPeopleList[index];
                          List images = [
                            'https://xsgames.co/randomusers/assets/avatars/male/${rand.nextInt(78)}.jpg',
                            'https://xsgames.co/randomusers/assets/avatars/female/${rand.nextInt(78)}.jpg'
                          ];
                          return FutureBuilder<String>(
                              future: trans(person),
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(children: [
                                    CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 30,
                                                )),
                                        imageBuilder: (context, imageProvider) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(ChatScreen(
                                                  nickname: snapshot.data!,
                                                  image:
                                                      images[rand.nextInt(2)],
                                                  nicknameeng: person));
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.grey[100],
                                              backgroundImage: NetworkImage(
                                                  images[rand.nextInt(2)]),
                                              radius: 30,
                                            ),
                                          );
                                        },
                                        imageUrl: images[rand.nextInt(2)]),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      snapshot.data!.isNotEmpty
                                          ? "${snapshot.data}"
                                          : userDataProvider
                                              .recentPeopleList[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ]);
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Column(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          color: Colors.grey[100],
                                          width: 60,
                                          height: 10,
                                        )
                                      ],
                                    ));
                              });
                        });
                  }),
            ],
          ),
        ),
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
            const Icon(Icons.mic, color: Colors.white, size: 26),
            5.width,
            Text('Tap to speak'.tr,
                style: primaryTextStyle(size: 16, color: Colors.white))
          ],
        ),
        onPressed: () {
          Get.to(Mic(
            currentRoute: '/ToPerson',
          ));
          // ExploreScreen().launch(context);
        },
      ).paddingOnly(bottom: 16),
    );
  }
}
