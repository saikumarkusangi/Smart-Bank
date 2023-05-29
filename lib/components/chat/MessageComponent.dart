import 'dart:async';

import 'package:bank/views/features/send/amount_Screen.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/models/smartbank_model.dart';
import 'package:bank/utils/Colors.dart';
import 'package:bank/utils/DataProvider.dart';
import 'package:bank/utils/my_separtor.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../constants/constants.dart';
import '../../models/message_model.dart';

class MessageComponent extends StatefulWidget {
  final String image;
  final String? nickname;
  final String? nicknameeng;

  @override
  MessageComponentState createState() => MessageComponentState();

  const MessageComponent(
      {super.key,
      required this.image,
      required this.nickname,
      required this.nicknameeng});
}

class MessageComponentState extends State<MessageComponent> {
  ScrollController scrollController = ScrollController();
  bool isTabSelected = true;

  @override
  List<MessagesModel> msgs = [];

  @override
  Widget build(BuildContext context) {
    Timer(Duration.zero, () {
      if (mounted) {
        scrollController.animToTop();
      }
    });
    final userDataProvider = Provider.of<UserController>(context);
    Widget details() {
      userDataProvider.history.map((e) {
        if (widget.nicknameeng == e['to-from']) {
          msgs.add(MessagesModel(
              amount: e['amount'], date: e['date'], time: e['time']));
        }
      }).validate();
      if (msgs.isEmpty) {
        return Align(
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            50.height,
            Hero(
              tag: 'Pay',
              child: CircleAvatar(
                backgroundColor: AppColor,
                radius: 48,
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ),
            10.height,
            Text(
              widget.nickname.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            10.height,
            Text(
              '+91 XXXXX XXXXX',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            20.height,
            const Text(
              'Say "Hello! 👋"',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ]),
        );
      }
      return ListView.builder(
          controller: scrollController,
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemCount: msgs.length,
          itemBuilder: (context, index) {
            print(msgs[index].time!);
            return Column(
              children: [
                //  msgs[index].date!.split("-")[1] == msgs[index].date!.split('-')[1] ?
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const MySeparator().withWidth(MediaQuery.of(context).size.width/3),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       child: Text(months[int.parse(
                //                   msgs[index].date!.split("-")[1]) -
                //               1]
                //           .toString()),
                //     ),
                //     const MySeparator().withWidth(MediaQuery.of(context).size.width/3),
                //   ],
                // ):const SizedBox(height: 0,),

                (index == msgs.length - 1)
                    ? Column(
                        children: [
                          50.height,
                          Hero(
                            tag: 'Pay',
                            child: CircleAvatar(
                              backgroundColor: AppColor,
                              radius: 48,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(widget.image),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.nickname.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          10.height,
                          Text(
                            '+91 XXXXX XXXXX',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          20.height,
                          msgs.isEmpty
                              ? const Text(
                                  'Say "Hello! 👋"',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )
                              : const SizedBox()
                        ],
                      )
                    : const SizedBox(),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: msgs[index].amount!.contains('-')
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 125,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue.withOpacity(0.2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${msgs[index].amount?.replaceAll('-', '')}',
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            msgs[index].amount!.contains('-')
                                ? '${'Paid to'.tr} ${widget.nickname}'
                                : 'Recevied to you'.tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                               Get.locale!.languageCode == 'te' ? '${msgs[index].date!.split("-")[2]} ${telugumonths[int.parse(msgs[index].date!.split("-")[1]) - 1]} ${int.parse(msgs[index].date!.split("-")[0])}'
                               : '${msgs[index].date!.split("-")[2]} ${months[int.parse(msgs[index].date!.split("-")[1]) - 1]} ${int.parse(msgs[index].date!.split("-")[0])}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                              Text(
                                DateFormat("h:mma").format(DateTime(
                                    0,
                                    0,
                                    0,
                                    int.parse(msgs[index].time!.split(':')[0]),
                                    int.parse(
                                        msgs[index].time!.split(':')[1]))),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                (index == 0)
                    ? const SizedBox(
                        height: 150,
                      )
                    : const SizedBox()
              ],
            );
          });
    }

    Widget textField() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          decoration:
              BoxDecoration(color: Colors.white, boxShadow: defaultBoxShadow()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                decoration: const BoxDecoration(
                    color: AppColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text("Pay".tr,
                    style: secondaryTextStyle(
                        size: 16,
                        color: backgroundColor,
                        weight: FontWeight.bold)),
              ).visible(isTabSelected).onTap(() {
                AmountPage(
                        image: widget.image,
                        nicknameeng: widget.nicknameeng!,
                        nickname: widget.nickname!)
                    .launch(context);
              }),
              8.width,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: const BoxDecoration(
                    color: AppColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text("Request".tr,
                    style: secondaryTextStyle(
                        size: 16,
                        color: backgroundColor,
                        weight: FontWeight.bold)),
              ).visible(isTabSelected),
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 16,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.navigate_next_outlined),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      isTabSelected = true;
                      hideKeyboard(context);
                    });
                  },
                ),
              ).onTap(() {}).visible(!isTabSelected),
              10.width,
              TextField(
                autofocus: false,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    filled: true,
                    suffixIcon: const Icon(Icons.navigate_next_outlined,
                            color: ColorBlack, size: 40)
                        .visible(!isTabSelected),
                    contentPadding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(color: Colors.grey[300]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(color: Colors.grey[300]!)),
                    hintText: widget.nickname!.isNotEmpty
                        ? 'Write to ${widget.nickname}'
                        : 'Type message',
                    hintStyle: primaryTextStyle(size: 14, color: Colors.grey)),
                style: primaryTextStyle(),
                onTap: () {
                  isTabSelected = false;
                  setState(() {});
                },
              ).expand(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          details(),
          textField(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
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
              currentRoute: '/ChatScreen',
              nickname: widget.nicknameeng!,
              img: widget.image));
          // ExploreScreen().launch(context);
        },
      ).paddingOnly(bottom: 80),
    );
  }
}
