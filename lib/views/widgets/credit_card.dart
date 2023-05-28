import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import '../../controllers/user_controller.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  GoogleTranslator translator = GoogleTranslator();

  Future<String> trans(msg) {
    return translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) async {
      return value.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserController>(context);
    return Stack(
      children: [
        SizedBox(child: Image.asset('assets/images/card_template.png')),
        // Positioned(
        //     top: 5,
        //     right: 20,
        //     child: SizedBox(
        //         width: 90, child: Image.asset('assets/images/upi_logo.jpg'))),
        Positioned(
            top: 70,
            right: 20,
            child: SizedBox(
                child: FutureBuilder<String>(
                    future: trans(userDataProvider.fullName),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data ?? userDataProvider.nickName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: const LinearProgressIndicator());
                    }))),
        Positioned(
            bottom: 90,
            right: 20,
            child: SizedBox(
                child: Text(
              'XXXX XXXX XXXX XXXX',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 18,
              ),
            ))),
      ],
    );
  }
}
