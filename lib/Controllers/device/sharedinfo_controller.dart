import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/device/sharedinfo_model.dart';

class sharedinfoController {
  List<sharedinfodata> sharedinfoList = [];

  Future<List<sharedinfodata>> fetchsharedinfoList(String deviceId) async {
    final url = 'http://192.168.1.150:5000/tempguard/user/shared/iHUAsursTMccEbi3gYQ6wQ'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        List<sharedinfodata> sharedInfoList = jsonData
            .map((sharedInfoData) => sharedinfodata.fromJson(sharedInfoData))
            .toList();
        return sharedInfoList;
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load shared user information');
    }
  }
//
}