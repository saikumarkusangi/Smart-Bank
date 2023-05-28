import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AsrApi {
  static api() async {
    try {
      final response = await http.post(
        Uri.parse('https://asr.iitm.ac.in/asr/v2/decode'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'language': Get.locale!.languageCode == 'en' ? "english" : "telugu",
            'vtt': 'true'
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final text = data['stt'];
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
