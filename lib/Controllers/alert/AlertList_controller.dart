import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/alert/AlertList_model.dart';

class alertlistController {
  List<alertlistdata> alertList = [];

  Future<List<alertlistdata>> fetchAlertList() async {
    final url =
        'http://192.168.1.150:5000/tempguard/device/alerts/iHUAsursTMccEbi3gYQ6wQ'; // Replace with the actual API endpoint for retrieving alerts.
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        for (var alertData in jsonData) {
          alertList.add(alertlistdata.fromJson(alertData));
        }

        return alertList;
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

//
}
