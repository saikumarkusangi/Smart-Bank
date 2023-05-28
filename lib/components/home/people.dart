import 'dart:math';

import 'package:bank/views/features/send/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';


class PeopleComponent extends StatefulWidget {
  final List getPeopleList;

  const PeopleComponent({super.key, required this.getPeopleList});

  @override
  _PeopleComponentState createState() => _PeopleComponentState();
}

class _PeopleComponentState extends State<PeopleComponent> {
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
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount:
          widget.getPeopleList.length >= 6 ? 6 : widget.getPeopleList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16.0),
      itemBuilder: (context, index) {
        List images = [
          'https://xsgames.co/randomusers/assets/avatars/male/${rand.nextInt(78)}.jpg',
          'https://xsgames.co/randomusers/assets/avatars/female/${rand.nextInt(78)}.jpg'
        ];
      final avatar =   images[rand.nextInt(2)];
        return FutureBuilder<String>(
            future: trans(widget.getPeopleList[index]),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: black,
                        backgroundImage:
                            NetworkImage(avatar)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data ?? widget.getPeopleList.toString(),
                        style: Theme.of(context).textTheme.bodySmall,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                ).onTap(() {
                  Get.to(ChatScreen(
                      nicknameeng: widget.getPeopleList[index],
                      nickname: snapshot.data ?? widget.getPeopleList[index],
                      image:avatar ));
                });
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
                                    width: 60,height: 10,
                                  )
                                    ],
                                  ));
            });
      },
    );
  }
}
