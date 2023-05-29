import 'dart:async';
import 'dart:math';
import 'package:bank/controllers/telugu_data_controller.dart';
import 'package:bank/services/services.dart';
import 'package:bank/views/features/send/to_person.dart';
import 'package:bank/views/views.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/components.dart';
import '../../../constants/constants.dart';
import '../../../controllers/controllers.dart';
import '../../../models/models.dart';
import '../../../utils/DataProvider.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static String tag = '/HomeScreen';
  final PeopleModel? data;
  const HomeScreen({
    super.key,
    this.data,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  List<BusinessTypeModel> getBusinessTypeList = getBusinessTypeData();
  List<PeopleModel> getBusinessList = getBusinessData();
  List<PeopleModel> getPromotionsList = getPromotionsData();
  int? tabIndex;
  final FlipCardController _cardController = FlipCardController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    tabIndex = 0;
  }

  GoogleTranslator translator = GoogleTranslator();

  Future<String> trans(msg) {
    return translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) {
      return value.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserController>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);
   


    print("#########################");
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&' +
        userDataProvider.recentPeopleList.length.toString());
    userDataProvider.recentPeople(context);

    print('balanceProvider.showbalance  ' +
        balanceProvider.showbalance.toString());

    if (balanceProvider.showbalance == true) {
      Timer(Duration.zero, () {
        if (mounted) {
          TtsApi.api('your account is ${userDataProvider.currentBalance}');
          _cardController.toggleCard();
        }
      });
      Timer(const Duration(seconds: 5), () {
        if (mounted) {
          balanceProvider.front();
          _cardController.toggleCard();
        }
      });
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              elevation: 0,
              backgroundColor: AppColor,
              actions: [
                IconButton(
                  icon: Image.asset(qrhomeicon,
                      height: 25, width: 25, color: backgroundColor),
                  onPressed: () {
                    Get.to(const QrScreen());
                  },
                )
                    .paddingOnly(right: 10)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 200.ms),
              ],
              leading: GestureDetector(
                onTap: () => Get.to(const ProfilePage()),
                child: const CircleAvatar(
                        backgroundImage: AssetImage(user), radius: 15)
                    .paddingLeft(10)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 100.ms),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Greetings.greetingText(),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  FutureBuilder<String>(
                      future: trans(userDataProvider.nickName),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data ?? userDataProvider.nickName,
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return const LinearProgressIndicator();
                      }),
                ],
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            ),
            body: Consumer<UserController>(
              builder: (context, value, child) => RefreshIndicator(
                  onRefresh: () async {},
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: [
                        Stack(children: [
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: const BoxDecoration(
                                color: AppColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 10),
                            child: SizedBox(
                              child: FlipCard(
                                controller: _cardController,
                                flipOnTouch: false,
                                fill: Fill
                                    .fillBack, // Fill the back side of the card to make in the same size as the front.
                                direction: FlipDirection.HORIZONTAL, // default
                                side: CardSide
                                    .FRONT, // The side to initially display.
                                front: const CreditCard(),
                                back: Stack(
                                  children: [
                                    Image.asset(
                                      cardbackside,
                                    ),
                                    Positioned(
                                        bottom: 40,
                                        left: 20,
                                        child: SizedBox(
                                            child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "Current Balance".tr,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            TextSpan(
                                                text:
                                                    "\n₹ ${userDataProvider.currentBalance}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 32,
                                                ))
                                          ]),
                                        ))),
                                  ],
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 100.ms),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: 10,
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 12),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                        height: 2,
                                        width: 25,
                                        color: Colors.grey[300])
                                    .paddingTop(10),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Transfer money".tr,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ).animate().moveX(
                                  duration: 400.ms, delay: 500.ms, begin: -500),
                              const SizedBox(
                                height: 25,
                              ),
                              GridView.builder(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                scrollDirection: Axis.vertical,
                                itemCount: sendMoney.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 16.0,
                                        childAspectRatio: 0.7),
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                      future:
                                          trans(sendMoney[index][0].toString()),
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          return Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: AppColor,
                                                radius: 25,
                                                child: Image.asset(
                                                    sendMoney[index][1],
                                                    height: 28,
                                                    width: 28,
                                                    color: backgroundColor),
                                              ),
                                              10.height,
                                              Text(
                                                  snap.data!.isNotEmpty
                                                      ? snap.data
                                                      : sendMoney[index][0],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                  textAlign: TextAlign.center)
                                            ],
                                          ).onTap(() {
                                            Timer(Duration.zero, () {
                                              if (mounted) {
                                                Get.to(sendMoney[index][2]);
                                              }
                                            });
                                          });
                                        } else if (snap.hasError) {
                                          return Text(snap.error.toString());
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
                                },
                              ).animate().moveX(
                                  duration: 400.ms,
                                  delay: 1200.ms,
                                  begin: -500),
                              const SizedBox(
                                height: 20,
                              ),
                              const MySeparator(color: Colors.grey)
                                  .paddingOnly(left: 20, right: 20)
                                  .animate()
                                  .fadeIn(duration: 400.ms, delay: 600.ms),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('People'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge)
                                          .paddingLeft(20))
                                  .animate()
                                  .fadeIn(duration: 400.ms, delay: 700.ms),
                              const SizedBox(
                                height: 15,
                              ),
                              GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: userDataProvider
                                                  .recentPeopleList.length >=
                                              6
                                          ? 6
                                          : userDataProvider
                                              .recentPeopleList.length,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 0.0,
                                              childAspectRatio: 1.2,
                                              crossAxisSpacing: 16.0),
                                      itemBuilder: (context, index) {
                                        final rand = Random();
                                        List images = [
                                          'https://xsgames.co/randomusers/assets/avatars/male/${rand.nextInt(78)}.jpg',
                                          'https://xsgames.co/randomusers/assets/avatars/female/${rand.nextInt(78)}.jpg'
                                        ];

                                        final avatar = images[rand.nextInt(2)];
                                        return FutureBuilder<String>(
                                            future: trans(userDataProvider
                                                .recentPeopleList[index]),
                                            builder: (context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.hasData) {
                                                return Column(
                                                  children: [
                                                    CircleAvatar(
                                                        radius: 30,
                                                        backgroundColor:
                                                            Colors.grey[100],
                                                        backgroundImage:
                                                            NetworkImage(
                                                                avatar)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      snapshot.data ??
                                                          userDataProvider
                                                              .recentPeopleList[
                                                                  index]
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ).onTap(() {
                                                  Get.to(ChatScreen(
                                                      nicknameeng: userDataProvider
                                                              .recentPeopleList[
                                                          index],
                                                      nickname: snapshot.data ??
                                                          userDataProvider
                                                                  .recentPeopleList[
                                                              index],
                                                      image: avatar));
                                                });
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    snapshot.error.toString());
                                              }
                                              return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Column(
                                                    children: [
                                                      const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
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
                                      })
                                  .animate()
                                  .moveX(
                                      duration: 400.ms,
                                      delay: 800.ms,
                                      begin: -500),
                              const SizedBox(
                                height: 20,
                              ),
                              const MySeparator(color: Colors.grey)
                                  .paddingOnly(left: 20, right: 20),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Featured'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      textStyle:
                                          const TextStyle(color: AppColor),
                                      backgroundColor: LightBlue,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0))),
                                    ),
                                    onPressed: () {
                                      Get.to(const ExploreScreen());
                                    },
                                    label: Text('Explore'.tr,
                                        style: primaryTextStyle(
                                            size: 14, color: AppColor)),
                                    icon: const Icon(Icons.grid_view_outlined,
                                        color: AppColor),
                                  ),
                                ],
                              )
                                  .paddingOnly(left: 20, right: 20)
                                  .animate()
                                  .fadeIn(duration: 400.ms, delay: 900.ms),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 45,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(5),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: explore.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return FutureBuilder(
                                        future: trans(explore[index][0]),
                                        builder: (context, snap) {
                                          if (snap.hasData) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[300]!),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    explore[index][1],
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  10.width,
                                                  Text(
                                                      snap.data!.isNotEmpty
                                                          ? snap.data
                                                          : explore[index][0],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall)
                                                ],
                                              ).paddingOnly(
                                                  left: 10, right: 10),
                                            )
                                                .paddingOnly(left: 5, right: 5)
                                                .onTap(() {
                                              Get.to(const ExploreScreen());
                                            });
                                          } else if (snap.hasError) {
                                            return Text(snap.error.toString());
                                          }
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    color: Colors.grey[100],
                                                    width: 80,
                                                    height: 30,
                                                  )
                                                ],
                                              ));
                                        });
                                  },
                                ).animate().moveX(
                                    duration: 400.ms,
                                    delay: 1200.ms,
                                    begin: -500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GridView.builder(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                scrollDirection: Axis.vertical,
                                itemCount: features.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 16.0,
                                        childAspectRatio: 0.7),
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                      future:
                                          trans(features[index][0].toString()),
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          return Column(
                                            children: [
                                              Container(
                                                  width: 55,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: blackColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                    color: backgroundColor,
                                                  ),
                                                  child: Image.asset(
                                                    features[index][1],
                                                    scale: 1.5,
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                snap.data!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ).onTap(() {
                                            launchUrl(
                                                Uri.parse(features[index][2]));
                                          });
                                        } else if (snap.hasError) {
                                          return Text(snap.error.toString());
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
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const MySeparator(color: Colors.grey)
                                  .paddingOnly(left: 20, right: 20),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Promotions'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                    .paddingLeft(20),
                              ).animate().moveX(
                                  begin: -100,
                                  duration: 400.ms,
                                  delay: 1100.ms),
                              const SizedBox(
                                height: 20,
                              ),
                              GridView.builder(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                scrollDirection: Axis.vertical,
                                itemCount: promotions.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 16.0,
                                        childAspectRatio: 0.7),
                                itemBuilder: (context, index) {
                                  return FutureBuilder(
                                      future: trans(
                                          promotions[index][0].toString()),
                                      builder: (context, snap) {
                                        if (snap.hasData) {
                                          return Column(
                                            children: [
                                              Container(
                                                  width: 55,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: blackColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                    color: backgroundColor,
                                                  ),
                                                  child: Image.asset(
                                                    promotions[index][1],
                                                    scale: 1.5,
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                snap.data!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ).onTap(() {
                                            Timer(Duration.zero, () {
                                              if (mounted) {
                                                Get.to(promotions[index][2]);
                                              }
                                            });
                                          });
                                        } else if (snap.hasError) {
                                          return Text(snap.error.toString());
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
                                },
                              ).animate().moveX(
                                  duration: 400.ms,
                                  delay: 1200.ms,
                                  begin: -500),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Image.asset(
                              //       paymentactivityimg,
                              //       width: 40,
                              //       color: Get.isDarkMode
                              //           ? Colors.white
                              //           : Colors.black,
                              //     ),
                              //     const SizedBox(
                              //       width: 10,
                              //     ),
                              //     Text("See all payments activity",
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .bodyMedium),
                              //     const Spacer(),
                              //     Icon(Icons.navigate_next,
                              //         color: Get.isDarkMode
                              //             ? Colors.white
                              //             : Colors.black),
                              //   ],
                              // )
                              //     .paddingOnly(left: 20, right: 20)
                              //     .onTap(() {
                              //       Get.to(const Transactions());
                              //     })
                              //     .animate()
                              //     .moveX(
                              //         begin: -500,
                              //         duration: 400.ms,
                              //         delay: 1300.ms),
                              Stack(
                                children: [
                                  commonCacheImageWidget(
                                    footer,
                                    fit: BoxFit.cover,
                                    height: 280,
                                  )
                                      .animate()
                                      .fadeIn(duration: 400.ms, delay: 1400.ms),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Invite your friends".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "Get ₹101 after each friend's first payment"
                                              .tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.grey[300]!)),
                                            backgroundColor: Colors.white,
                                            textStyle: const TextStyle(
                                              color: ColorBlack,
                                            )),
                                        onPressed: () async {
                                          await Share.share(
                                              '${"Get "}\u{20B9}${"101 after each friend's first payment"}');
                                        },
                                        child: Text("Invite".tr,
                                                style: const TextStyle(
                                                    fontSize: 18.0))
                                            .paddingSymmetric(horizontal: 20),
                                      ),
                                    ],
                                  )
                                      .paddingOnly(
                                          left: 30, right: 30, bottom: 30)
                                      .animate()
                                      .moveX(
                                          duration: 400.ms,
                                          delay: 1600.ms,
                                          begin: -500),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: AppColor,
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 15,
                          right: 20,
                          left: 20,
                        ),
                        // right: scrollProvider.visibility ? 20 : 10,
                        // left: scrollProvider.visibility ? 20 : 10),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(28.0))),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.mic,
                              color: backgroundColor, size: 26),
                          Text('Tap to speak'.tr,
                              style: primaryTextStyle(
                                  size: 16, color: backgroundColor))
                        ],
                      ),
                      onPressed: () {
                        Get.to(Mic(
                          currentRoute: '/HomeScreen',
                        ));
                        // ExploreScreen().launch(context);
                      },
                    )
                        .paddingOnly(bottom: 16)
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 2000.ms),
                  ])),
            )));
  }
}
