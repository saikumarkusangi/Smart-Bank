import 'dart:math';
import 'package:bank/views/views.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import '../../../constants/constants.dart';
import '../../../utils/utils.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem(this.data, {Key? key, this.onTap}) : super(key: key);
  final Map data;
  final GestureTapCallback? onTap;
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
    final rand = Random();
    List images = [
      'https://xsgames.co/randomusers/assets/avatars/male/${rand.nextInt(78)}.jpg',
      'https://xsgames.co/randomusers/assets/avatars/female/${rand.nextInt(78)}.jpg'
    ];
    final avatar = images[rand.nextInt(2)];
    final send = data['amount'];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final twodaysago = DateTime(now.year, now.month, now.day - 2);
    return FutureBuilder<String>(
        future: trans('${data['to-from']}'),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              onTap: onTap,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode ? backgroundColorDark : backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              backgroundImage: NetworkImage(avatar),
                              radius: 30,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                  Text(
                                          (!send.toString().contains("-"))
                                              ? "${'Received from'.tr}\n${snapshot.data}"
                                              : "${'Money sent to'.tr}\n${snapshot.data}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700))
                                      .onTap(() {
                                    Get.to(ChatScreen(
                                        nickname: '${snapshot.data}',
                                        image: avatar,
                                        nicknameeng: '${data['to-from']}'));
                                  }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: (data['date'] ==
                                                DateFormat('yyyy-MM-dd')
                                                    .format(today)
                                                    .toString())
                                            ? const Text('Today')
                                            : (data['date'] ==
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(yesterday)
                                                        .toString())
                                                ? const Text('Yesterday')
                                                : (data['date'] ==
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(twodaysago)
                                                            .toString())
                                                    ? const Text('2 days ago')
                                                    : Text(
                                                        '${data['date'].split("-")[2]} ${months[int.parse(data['date'].split("-")[1]) - 1]} ${int.parse(data['date'].split("-")[0])}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                      ),
                                      Text(
                                          DateFormat("h:mma").format(DateTime(
                                              0,
                                              0,
                                              0,
                                              int.parse(
                                                  data['time'].split(':')[0]),
                                              int.parse(
                                                  data['time'].split(':')[1]))),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                ])),
                            Column(
                              children: [
                                Text('₹${data['amount']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: (!send.toString().contains("-"))
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Container(
                                    child: !send.toString().contains("-")
                                        ? const Icon(
                                            Icons.download_rounded,
                                            color: Colors.green,
                                          )
                                        : const Icon(
                                            Icons.upload_rounded,
                                            color: Colors.red,
                                          )),
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      const MySeparator()
                    ],
                  )),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[100]!,
                      )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                        Container(
                          color: Colors.grey[100],
                          height: 15,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey[100],
                              height: 10,
                              width: 80,
                            ),
                          ],
                        ),
                      ])),
                ]),
                const SizedBox(
                  height: 20,
                ),
                const MySeparator()
              ],
            ),
          );
        });
  }
}
