import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
    final FlutterTts tts = FlutterTts();
    late String text;

    Future<void> initializeTts() async {
      tts.setStartHandler(() {});
      tts.setCompletionHandler(() {});
      tts.setErrorHandler((message) {});

      await tts.awaitSpeakCompletion(true);
      await tts.setLanguage("ko-KR");
      await tts.setSpeechRate(0.75);
      await tts.setVolume(1);
      await tts.setPitch(1);
    }

    Future speak(text) async {
      await tts.speak(text);
    }

    Future stop() async {
      await tts.stop();
    }
}