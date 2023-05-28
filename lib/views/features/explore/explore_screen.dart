import 'package:bank/components/components.dart';
import 'package:bank/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../utils/utils.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  ExploreScreenState createState() => ExploreScreenState();
}

class ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool isStopped = false;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
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
            currentRoute: '/ExplorePage',
          ));
        },
      ).paddingOnly(bottom: 16),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        backgroundColor: AppColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leadingWidth: 0,
        centerTitle: true,
        elevation: 1,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_backspace, color: white),
              onPressed: () {
                finish(context);
              },
            ),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                fillColor: white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.grey[300]!)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.grey[300]!)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.grey[300]!)),
                hintText: 'Search Smart Bank Servies',
                hintStyle: secondaryTextStyle(size: 12, color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
              ),
              onTap: () {
                //   hideKeyboard(context);
              },
            ).expand(),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined, color: white),
              onSelected: (dynamic v) {
                toast('Click');
              },
              itemBuilder: (BuildContext context) {
                List<PopupMenuEntry<Object>> list = [];

                list.add(const PopupMenuItem(
                    value: 1,
                    child:
                        Text("Refresh", style: TextStyle(color: ColorBlack))));
                list.add(const PopupMenuItem(
                    value: 1,
                    child: Text("Send feedback",
                        style: TextStyle(color: ColorBlack))));
                return list;
              },
            )
          ],
        ).paddingOnly(top: 5, bottom: 5),
      ),
      body: const BusinessesComponent(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
