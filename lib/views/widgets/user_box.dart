import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/images.dart';
import 'avatar_image.dart';

class UserBox extends StatelessWidget {
 const UserBox(
      {Key? key,
      required this.user,
      this.isSVG = false,
      this.width = 55,
      this.height = 55})
      : super(key: key);
  final Map  user;
  final double width;
  final double height;
  final bool isSVG;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarImage(
          Images.avatars[Random().nextInt(4)],
          isSVG: isSVG,
          width: width,
          height: height,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          user["to-from"],
          style: const TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
