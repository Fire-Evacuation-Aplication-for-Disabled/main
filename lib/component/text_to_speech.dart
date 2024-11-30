import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
    final FlutterTts tts = FlutterTts();
    late String text;

    void initState(){
      tts.setLanguage("ko-KR");
      tts.setSpeechRate(2);
      tts.setVolume(0.75);
      tts.setPitch(1);
    }

    Future speak(text) async {
      await tts.speak(text);
    }

    Future stop() async {
      await tts.stop();
    }
}