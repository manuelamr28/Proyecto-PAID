import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tablero_caa/models/credit.dart';
import 'package:tablero_caa/models/data_caa.dart';
import 'dart:convert';

import 'package:tablero_caa/models/menu.dart';

class DataManager {
  final String url =
      "https://api.github.com/gists/7c1e028c8a741d80dbb1083cbf873f28";
  final String key = "data_caa_config";
  late DataCaa dataCaa;

  Future<DataCaa> getData() async {
    bool isConnect = await _checkConnection();
    String data;

    if (isConnect) {
      data = await fetchDataFromUrl();
    } else {
      data = await getLocalStorage(key);
    }

    if (data.isNotEmpty) {
      setLocalStorage(key, data);
      dataCaa = await parseJsonToDataCaa(data);
    }
    dataCaa.version = isConnect ? "online" : "offline";
    return dataCaa;
  }

  Future<DataCaa> parseJsonToDataCaa(String dataJson) async {
    final Map<String, dynamic> data = json.decode(dataJson);

    List<Menu> menuList = (data['menu'] as List<dynamic>)
        .map((menuData) => Menu.fromJson(menuData as Map<String, dynamic>))
        .toList();

    List<Credit> creditsList = (data['credits'] as List<dynamic>)
        .map(
            (creditData) => Credit.fromJson(creditData as Map<String, dynamic>))
        .toList();

    Map<String, String> imagesMap = (data['images'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, value as String));

    return DataCaa()
      ..version = data['version'] as String
      ..menu = menuList
      ..credits = creditsList
      ..images = imagesMap;
  }

  Future setLocalStorage(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getLocalStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  Future<String> fetchDataFromUrl() async {
    final apiResponse = await http.get(
      Uri.parse(url),
    );

    if (apiResponse.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(apiResponse.body);
      String rawUrl = jsonResponse['files']['caa-setting.json']['raw_url'];
      final response = await http.get(
        Uri.parse(rawUrl),
      );
      if (response.statusCode == 200) {
        return response.body;
      }
    }

    return "";
  }

  Future<bool> _checkConnection() async {
    InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker();
    final bool isConnected = await internetConnectionChecker.hasConnection;
    return isConnected;
  }
}
