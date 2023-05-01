import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
 _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final stt.SpeechToText speech = stt.SpeechToText();
  final TextEditingController _textEditingController = TextEditingController();
  final bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  Future<void> initSpeechRecognizer() async {
    bool isAvailable = await speech.initialize(
        onStatus: (status) => print('Speech recognizer status: $status'),
        onError: (error) => print('Speech recognizer error: $error'));

    if (isAvailable) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Voice Recognition TextField'),
        ),
        body: Column(
          children: [
            (_isListening)
                ? const Text('listening')
                : const Text('not listenij g'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Type here or press the mic button',
              ),
              controller: _textEditingController,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (speech.isAvailable) {
              try {
                speech.listen(
                  onResult: (res) {
                    setState(() {
                      _textEditingController.text = res.recognizedWords;
                    });
                  },
                );
              } catch (e) {
                rethrow;
              }
            }
          },
          child: Icon(_isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
