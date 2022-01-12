import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextSpeaker extends ChangeNotifier {

  FlutterTts tts = FlutterTts();

  Future setLanguageToEnglish() async {
    //await _getDefaultEngine();
    await tts.setLanguage('en-US');
  }

  Future speakInGirlVoice(String text) async {
    await tts.setVolume(1);
    await tts.setSpeechRate(0.4);
    await tts.setPitch(0.8666);
   // await tts.awaitSpeakCompletion(true);
    await tts.speak(text);
  }

  Future _getDefaultEngine() async {
    var engine = await tts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }
}
