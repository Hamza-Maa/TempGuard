import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/device/devicelist_model.dart';

class devicelistController {
  List<devicelistdata> deviceList = [];

  Future<List<devicelistdata>> fetchdeviceList() async {
    final url =
        'http://192.168.1.150:5000/tempguard/user/devices/iHUAsursTMccEbi3gYQ6wQ'; // Replace with the actual API endpoint for retrieving alerts.
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        for (var deviceData in jsonData) {
          deviceList.add(devicelistdata.fromJson(deviceData));
        }
        print(deviceList);



        return deviceList;
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

//
}