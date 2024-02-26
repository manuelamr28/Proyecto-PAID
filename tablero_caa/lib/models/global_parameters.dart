import 'package:flutter/foundation.dart';
import 'package:tablero_caa/models/credit.dart';

class GlobalParameters with ChangeNotifier, DiagnosticableTreeMixin {
  List<Credit> _credits = [];
  bool _enabledTts = true;
  bool _isOnline = true;
  Map<String, String> _imagesMap = {};

  List<Credit> get credits => _credits;
  bool get enabledTts => _enabledTts;
  bool get isOnline => _isOnline;
  Map<String, String> get imagesMap => _imagesMap;

  void setCredistList(List<Credit> list) => _credits = list;
  void changeStatusTts() => _enabledTts = !_enabledTts;
  void setMapImages(Map<String, String> imagesMap) => _imagesMap = imagesMap;
  void setOnlineStatus(bool status) => _isOnline = status;
}
