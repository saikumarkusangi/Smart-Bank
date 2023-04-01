import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'avatar_image.dart';

class TransactionItem extends StatelessWidget {
  TransactionItem(this.data, {Key? key, this.onTap}) : super(key: key);
  final data;
  final GestureTapCallback? onTap;
  
  @override
  Widget build(BuildContext context) {
    final send = data['amount'];
    final rand = Random().nextInt(4);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final twodaysago = DateTime(now.year, now.month, now.day - 2);
  
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ThemeColors.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarImage(
                  Images.avatars[rand],
                  isSVG: false,
                  width: 45,
                  height: 45,
                  radius: 50,
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                child: Text(
                                  
                                    (!send.toString().contains("-"))
                                        ? "${'Received from'.tr} ${data['to-from']}"
                                        : "${'Money sent to'.tr} ${data['to-from']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)))),
                        SizedBox(width: 5),
                        Container(
                            child: Text('₹${data['amount']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: (!send.toString().contains("-"))
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)))
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child:
                                (data['date'] ==
                                            DateFormat('yyyy-MM-dd')
                                                .format(today)
                                                .toString())
                                        ? Text('Today') : 
                                        (data['date'] ==
                                            DateFormat('yyyy-MM-dd')
                                                .format(yesterday)
                                                .toString())
                                        ? Text('Yesterday') : 
                                        (data['date'] ==
                                            DateFormat('yyyy-MM-dd')
                                                .format(twodaysago)
                                                .toString())
                                        ? Text('2 days ago') :
                                            Text(
                                       data['date'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black38))),
                            Container(
                                child: Text(data['time'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black26))),
                          ],
                        ),
                        Container(
                            child: !send.toString().contains("-")
                                ? Icon(
                                    Icons.download_rounded,
                                    color: ThemeColors.green,
                                  )
                                : Icon(
                                    Icons.upload_rounded,
                                    color: ThemeColors.red,
                                  )),
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
