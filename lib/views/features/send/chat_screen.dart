
import 'package:bank/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/chat/MessageComponent.dart';

class ChatScreen extends StatefulWidget {
  static String tag = '/ChatScreen';

  final String nickname;
  final String nicknameeng;
  final String image;

  const ChatScreen({super.key, required this.nickname,required this.image,required this.nicknameeng});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        elevation: 0,
        iconTheme:const IconThemeData(
          color: Colors.white
        ),
        leading: IconButton(icon: const Icon(Icons.arrow_back_sharp),
        onPressed: ()=>Get.back(),),
        backgroundColor: AppColor,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined, color: white),
            onSelected: (dynamic v) {
              toast('Click');
              hideKeyboard(context);
            },
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<Object>> list = [];

              list.add(const PopupMenuItem(value: 1, child: Text("Block", style: TextStyle(color: ColorBlack))));
              list.add(const PopupMenuItem(value: 1, child: Text("Disable chat", style: TextStyle(color: ColorBlack))));
              list.add(const PopupMenuItem(value: 1, child: Text("Report spam", style: TextStyle(color: ColorBlack))));
              list.add(const PopupMenuItem(value: 1, child: Text("Refresh", style: TextStyle(color: ColorBlack))));
              list.add(const PopupMenuItem(value: 1, child: Text("Send feedback", style: TextStyle(color: ColorBlack))));

              return list;
            },
          )
        ],
      ),
      body: MessageComponent(
        image: widget.image,
        nicknameeng:widget.nicknameeng ,
        nickname: widget.nickname,),
    );
  }
}
