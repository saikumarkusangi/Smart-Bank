import 'package:avatar_glow/avatar_glow.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import '../../controllers/mic_controller.dart';

class Mic extends StatefulWidget {
  const Mic({Key? key}) : super(key: key);

  @override
  State<Mic> createState() => _MicState();
}

class _MicState extends State<Mic> {
  late stt.SpeechToText _speech;
  final FlutterTts flutterTts = FlutterTts();
  String recognizedwords = '';
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  GoogleTranslator translator = GoogleTranslator();
  var output = '';
  void trans(msg) {
    translator
        .translate(msg, to: Get.locale!.languageCode.toString())
        .then((value) {
      setState(() {
        output = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final micProvider = Provider.of<MicController>(context);

    return Stack(
      children: [
        AvatarGlow(
          animate: micProvider.isListening,
          glowColor: Colors.red,
          endRadius: 100,
          showTwoGlows: true,
          duration: const Duration(milliseconds: 800),
          repeat: true,
          child: GestureDetector(
            onLongPressStart: (start) async {
              // final player1 = AudioPlayer();
              //      await player1.setAsset('assets/audios/listening.mp3');
              //      await player1.play();
              if (!micProvider.isListening) {
                // if (micProvider.text.isNotEmpty) {
                //   micProvider.listen(context);
                // }
                bool available = await _speech.initialize(
                    // onStatus: (val) => print('onStatus : $val'),
                    // onError: (val) => print('onError : $val'),
                    );
                if (available) {
                  micProvider.listening(true);
                  _speech.listen(onResult: (val) async {
                    // micProvider.text.add(val.recognizedWords.toLowerCase().trim());

                    setState(() {
                      recognizedwords = val.recognizedWords;
                      trans(recognizedwords);
                    });

                    micProvider.text.add(recognizedwords.toLowerCase());
                  });
                  micProvider.text.add(recognizedwords.toLowerCase());
                  micProvider.listen(context);
                  setState(() {
                    recognizedwords = '';
                  });
                  // Timer(Duration(seconds: 3), () {
                  //   print('stopping');

                  //   micProvider.listening(false);

                  //   _speech.stop();
                  // });
                } else {
                  setState(() {
                    micProvider.listening(false);
                    _speech.stop();
                  });
                }
              }
            },
            onLongPressEnd: (end) async {
              micProvider.listening(false);
              _speech.stop();
              micProvider.text.add(recognizedwords.toLowerCase());
              micProvider.listen(context);
              setState(() {
                recognizedwords = '';
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Icon(
                    micProvider.isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 38,
                  )),
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                output.toString(),
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            )),
      ],
    );
  }
}
