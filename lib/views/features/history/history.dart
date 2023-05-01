import 'package:bank/constants/constants.dart';
import 'package:bank/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../widgets/transaction_item.dart';
import '../../widgets/widgets.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
      final userDataProvider = Provider.of<UserController>(context);
      
    return Scaffold(
      backgroundColor: ThemeColors.secondary,
      appBar: AppBar(
        title: Text('Transactions'.tr,style: const TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        backgroundColor: ThemeColors.purple,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<UserController>(
          builder: (context, value, child) => RefreshIndicator(
            onRefresh: () async {
              value.transactions(nickName:userDataProvider.nickName.trim());
            },
            child: ListView.builder(
                physics:const BouncingScrollPhysics(),
                 itemCount:  10,
                 itemBuilder: (context,index) => TransactionItem(value.history[index])),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Mic(),
    );
  }
}
