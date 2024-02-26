import 'package:paid_didactico/models/credit.dart';
import 'package:paid_didactico/models/module.dart';

class DataPaid {
  late List<Module> modules;
  late List<Credit> credits;
  late Map<String, String> images;
  DataPaid() {
    modules = List.empty();
    credits = List.empty();
    images = {};
  }

  DataPaid.fromJson(Map<String, dynamic> data) {
    List<Module> moduleList = (data['modules'] as List<dynamic>)
        .map((module) => Module.fromJson(module as Map<String, dynamic>))
        .toList();

    List<Credit> creditsList = (data['credits'] as List<dynamic>)
        .map((credit) => Credit.fromJson(credit as Map<String, dynamic>))
        .toList();

    Map<String, String> imagesMap = (data['images'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, value as String));

    modules = moduleList;
    credits = creditsList;
    images = imagesMap;
  }
}
