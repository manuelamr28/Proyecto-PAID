import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataManager {
  final String url = "https://api.github.com/gists/";
  final String gistId;
  final String key;
  late Map<String, dynamic> dataObject = {};

  DataManager({required this.gistId, required this.key});

  Future<Map<String, dynamic>> getData() async {
    bool isConnect = await _checkConnection();
    String data;

    if (isConnect) {
      data = await fetchDataFromUrl();

      if (data.isNotEmpty) {
        dataObject = await parseJsonToData(data);
      }
    }

    return dataObject;
  }

  Future<bool> _checkConnection() async {
    InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker();
    final bool isConnected = await internetConnectionChecker.hasConnection;
    return isConnected;
  }

  Future<String> fetchDataFromUrl() async {
    final apiResponse = await http.get(
      Uri.parse(url + gistId),
    );

    if (apiResponse.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(apiResponse.body);
      String rawUrl = jsonResponse['files'][key]['raw_url'];
      final response = await http.get(
        Uri.parse(rawUrl),
      );
      if (response.statusCode == 200) {
        return response.body;
      }
    }

    return "";
  }

  Future<Map<String, dynamic>> parseJsonToData(String dataJson) async {
    final Map<String, dynamic> data = json.decode(dataJson);
    return data;
  }
}
