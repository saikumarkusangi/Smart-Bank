// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RecordPage extends StatefulWidget {
const RecordPage({Key? key}) : super(key: key);

@override
State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final FlutterTts flutterTts = FlutterTts();
  
 listen(message) async {

await flutterTts.setLanguage('en-US'); // set the language (optional)
await flutterTts.setSpeechRate(1.0); // set the speech rate (optional)
await flutterTts.setVolume(1.0);
 await flutterTts.speak(message);

  }

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Dashboard"),
actions: const [],
),
body: SingleChildScrollView(
child: Container(
padding: const EdgeInsets.all(10.0),
child: Column(
children: [
  InkWell(
    onTap: listen('hello'),
    child: const Chip(label: Text('Listen'),))
],
),
),
),
);
}
}








String gender = 'male';
String lang = 'Hindi';
String text = 'चॉकलेट आइसक्रीम बनाने की विधि बताओ';

String url = 'https://asr.iitm.ac.in/ttsv2/tts'; // Endpoint

Map<String, dynamic> payload = {
  'input': text,
  'gender': gender,
  'lang': lang,
  'alpha': 1,
  'segmentwise': true
};

var response =  http.post(
  Uri.parse(url),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(payload),
);

// Map<String, dynamic> responseData = jsonDecode(response.body);

// String audio = responseData['audio']; // encoded speech data
// String fileName = 'tts.wav'; // output file name
// var wavFile = File(fileName).openSync(mode: FileMode.write); // creating an empty file
// List<int> decodeString = base64.decode(audio); // decoding audio file
