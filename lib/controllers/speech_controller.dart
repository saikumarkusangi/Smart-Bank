import 'package:flutter_tts/flutter_tts.dart';

class SpeechController {
  static final FlutterTts flutterTts = FlutterTts();

  static listen(message) async {
    await flutterTts.setLanguage('en-IN'); // set the language (optional)
    await flutterTts.setSpeechRate(0.5); // set the speech rate (optional)
    await flutterTts.setVolume(1.0);
    await flutterTts.awaitSpeakCompletion(true);

    await flutterTts.speak(message);
  }

//  Future.delayed(Duration(milliseconds:10 ),
//  ()=> flutterTts.stop()
//  );
//   }
//   static stop() async {

//  await flutterTts.stop();
}
