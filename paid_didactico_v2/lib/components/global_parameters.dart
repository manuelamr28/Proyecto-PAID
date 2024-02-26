import 'package:flutter/foundation.dart';
import 'package:paid_didactico/models/credit.dart';
import 'package:paid_didactico/models/soundpool.dart';
import 'package:paid_didactico/models/tts.dart';

class GlobalParameters with ChangeNotifier, DiagnosticableTreeMixin {
  List<Credit> _credits = [];
  bool _enabledTts = true;
  bool _isOnline = true;
  Map<String, String> _imagesMap = {};
  final SoundPool _soundPool = SoundPool();
  final Tts _ttsService = Tts();

  List<Credit> get credits => _credits;
  bool get enabledTts => _enabledTts;
  bool get isOnline => _isOnline;
  Map<String, String> get imagesMap => _imagesMap;
  SoundPool get soundPool => _soundPool;
  Tts get ttsService => _ttsService;

  void setCredistList(List<Credit> list) => _credits = list;
  void changeStatusTts() => _enabledTts = !_enabledTts;
  void setMapImages(Map<String, String> imagesMap) => _imagesMap = imagesMap;
  void setOnlineStatus(bool status) => _isOnline = status;
}
