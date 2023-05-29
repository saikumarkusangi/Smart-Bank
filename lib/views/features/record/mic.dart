import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import '../../../controllers/mic_controller.dart';
import '../../../utils/images.dart';

class Mic extends StatefulWidget {
  String nickname;
  String img;
  String name;
  Mic(
      {Key? key,
      required this.currentRoute,
      this.nickname = '',
      this.img = '',
      this.name = ''})
      : super(key: key);
  final String currentRoute;
  @override
  State<Mic> createState() => _MicState();
}

class _MicState extends State<Mic> {
  late stt.SpeechToText _speech;
  final FlutterTts flutterTts = FlutterTts();
  String recognizedwords = '';
  bool listening = false;
  bool availableMic = false;
  String output = 'Listening....';
  String teloutput = 'వింటుంది';
  bool longpress = false;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  GoogleTranslator translator = GoogleTranslator();

  void trans(msg) {
    translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) {
      setState(() {
        output = value.toString();
        teloutput = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final micProvider = Provider.of<MicController>(context);
    micProvider.setDetails(widget.nickname, widget.img);
    checkMic() async {
      await _speech.initialize();
    }

    if (!micProvider.isListening && longpress == false) {
      checkMic();
      Timer(const Duration(seconds: 3), () {
        micProvider.listening(false);
      });

      micProvider.listening(true);
      _speech.listen(onResult: (val) async {
        setState(() {
          // output = val.recognizedWords;
          recognizedwords = val.recognizedWords;
          trans(recognizedwords);
        });

        micProvider.text.add(recognizedwords.toLowerCase());
      });

      micProvider.text.add(recognizedwords.toLowerCase());
      micProvider.listen(context, widget.currentRoute, widget.name);
      micProvider.setEmpty();
    if(Get.locale!.languageCode == 'te'){
  setState(() {
        if (teloutput != 'వింటుంది....') {
          micProvider.listening(false);
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              teloutput = '';
            });
          });
        }
        if (micProvider.notFound == true && teloutput == '') {
          // TtsApi.api('No recognized try again');
          // SpeechController.listen('No recognized try again');
          micProvider.setNotFound(false);
          micProvider.text.add('try again'.tr);
          setState(() {
            teloutput = 'try again'.tr;
          });
        }

        recognizedwords = '';
      });
    }else{
  setState(() {
        if (output != 'Listening....') {
          micProvider.listening(false);
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              output = '';
            });
          });
        }
        if (micProvider.notFound == true && output == '') {
          // TtsApi.api('No recognized try again');
          // SpeechController.listen('No recognized try again');
          micProvider.setNotFound(false);
          micProvider.text.add('try again'.tr);
          setState(() {
            output = 'try again';
          });
        }

        recognizedwords = '';
      });
    }
    } else {
      // setState(() {
      //   micProvider.listening(false);
      //   _speech.stop();
      // });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor,
        elevation: 0,
        leading: IconButton(
            color: backgroundColor,
            onPressed: () {
              micProvider.setEmpty();
              setState(() {
                output = '';
                recognizedwords = '';
              });
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              size: 28,
            )),
      ),
      backgroundColor: AppColor,
      body: Stack(
        children: [
          Visibility(
              visible: micProvider.isListening || longpress,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    listeninggif,
                    color: Colors.white,
                    scale: 1.5,
                  ))),
          Align(
            alignment: Alignment.bottomCenter,
            child: AvatarGlow(
              animate: micProvider.isListening || longpress,
              glowColor: Colors.white,
              endRadius: 100,
              showTwoGlows: true,
              duration: const Duration(milliseconds: 800),
              repeat: true,
              child: GestureDetector(
                onLongPressStart: (v) async {
                  setState(() {
                    output = 'Listening....'.tr;
                    longpress = true;
                  });
                  micProvider.listening(true);
                  _speech.listen(onResult: (val) async {
                    // micProvider.text.add(val.recognizedWords.toLowerCase().trim());
                    setState(() {
                      // listening = true;
                      recognizedwords = val.recognizedWords;
                      trans(recognizedwords);
                    });

                    micProvider.text.add(recognizedwords.toLowerCase());
                  });
                  micProvider.text.add(recognizedwords.toLowerCase());
                  micProvider.listen(context, widget.currentRoute, widget.name);
                  micProvider.setEmpty();
                  setState(() {
                    output = 'Listening....'.tr;
                    recognizedwords = '';
                  });
                  // Timer(Duration(seconds: 3), () {
                  //   print('stopping');

                  //   micProvider.listening(false);

                  //   _speech.stop();
                  // });
                },
                onLongPressEnd: (v) async {
                  setState(() {
                    longpress = false;
                  });
                  micProvider.listening(false);
                  _speech.stop();
                  micProvider.text.add(recognizedwords.toLowerCase());
                  micProvider.listen(context, widget.currentRoute, widget.name);
                  if (micProvider.notFound == true && output == '') {
                    // TtsApi.api('No recognized try again');
                    // SpeechController.listen('No recognized try again');
                    micProvider.setNotFound(false);
                    micProvider.text.add('try again');
                    setState(() {
                      output = '';
                      recognizedwords = '';
                    });
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Icon(
                        micProvider.isListening ? Icons.mic : Icons.mic_none,
                        color: AppColor,
                        size: 38,
                      )),
                ),
              ),
            ),
          ),
         Get.locale!.languageCode == 'en' ? Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  output.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )):
              Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  teloutput.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Long press to try again'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
