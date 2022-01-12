import 'package:speech_to_text/speech_to_text.dart' ;


class VoiceToText
{
  SpeechToText speech = SpeechToText();
    Future checkIfAvailable()async{
      bool available = await  speech.initialize(
        onStatus: (val)=>print("on status:- $val"),
        onError: (e)=>print("on error:- $e")
      );
      //List<LocaleName> list = await _speech.locales();
      //list.forEach((element) {print(element.name+element.localeId);});
      return available;
    }

    listenVoice(Function onListen){
       speech.listen(
         localeId: "en_US",
         listenFor: Duration(seconds: 30),
         pauseFor: Duration(seconds: 4),
         listenMode: ListenMode.deviceDefault,
         onResult: (val){
           onListen(val.recognizedWords);
         }
       );
       print("--------------------------${speech.isNotListening}");
    }

    stop(){
      speech.stop();
    }

}