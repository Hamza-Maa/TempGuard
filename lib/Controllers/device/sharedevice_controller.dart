import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/device/sharedevice_model.dart';

class sharedeviceController {
  final String apiUrl; // Replace this with your actual API endpoint URL.

  sharedeviceController(this.apiUrl);

  Future<int> sharedevice(SharedeviceData sharedata) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(sharedata.toJson());

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      print(response.statusCode);
      return response.statusCode; // Return the status code

    } catch (e) {
      print('Error: $e');
      return 500; // Return a default status code for error
    }
  }

}