import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TtsApi {
  static api(input) async {
    try {
      final response = await http.post(
        Uri.parse('https://asr.iitm.ac.in/ttsv2/tts'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "input": input,
            "gender": "Female",
            "lang":Get.locale!.languageCode == 'en' ? "English" : "Telugu",
            "alpha": 1,
            "segmentwise": "True"
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final base64 = data['audio'];
        final url = 'data:audio/mp3;base64,$base64';
        AudioPlayer audioPlayer = AudioPlayer();
        await audioPlayer.play(UrlSource(url));
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
