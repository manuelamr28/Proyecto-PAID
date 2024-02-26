import 'package:flutter_tts/flutter_tts.dart';

class Tts {
  FlutterTts flutterTts = FlutterTts();

  Tts() {
    configTts();
  }
  Future configTts() async {
    double volume = 0.5;
    double pitch = 1.0;
    double rate = 0.5;

    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(pitch);
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
  }

  Future speak(String word) async {
    await flutterTts.speak(word);
  }
}
