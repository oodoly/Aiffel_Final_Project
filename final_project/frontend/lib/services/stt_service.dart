import 'package:speech_to_text/speech_to_text.dart' as stt;

class STTService {
  static final STTService _instance = STTService._internal();
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  factory STTService() {
    return _instance;
  }

  STTService._internal() {
    _initializeSTT();
  }

  void _initializeSTT() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) => print('STT Status: $status'),
      onError: (error) => print('STT Error: $error'),
    );
    if (!available) {
      print("STT 기능을 사용할 수 없습니다.");
    }
  }

  void startListening(Function(String) onResult) {
    _speechToText.listen(onResult: (result) {
      onResult(result.recognizedWords);
    });
  }

  void stopListening() {
    _speechToText.stop();
  }
}
