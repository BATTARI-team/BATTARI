import 'package:avatar_glow/avatar_glow.dart';
import 'package:battari/color.dart';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  var text = "音声を文字に変換します";
  var isListening = false;

  // テキストを初期状態に戻す関数
  void resetText() {
    setState(() {
      text = "音声を文字に変換します";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: AvatarGlow(
          //endRadius: 75.0,
          animate: isListening,
          duration: const Duration(milliseconds: 2000),
          glowColor: BG_COLOR,
          //repeatPauseDuration: const Duration(milliseconds: 100),
          //showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(
                      onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                        });
                      },
                      localeId: 'ja_JP', // 日本語の設定
                    );
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                isListening = false;
              });
              speechToText.stop();
            },
            child: CircleAvatar(
              backgroundColor: BG_COLOR,
              radius: 35,
              child: Icon(
                isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: BG_COLOR,
          title: const Text(
            '音声を文字に変換アプリ',
            style: TextStyle(fontWeight: FontWeight.w600, color: TEXT_COLOR),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30), // スペースを追加
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: BG_COLOR,
                  foregroundColor: Colors.white,
                ),
                onPressed: resetText, // リセット関数を呼び出す
                child: const Text('テキストをリセット'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
