import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../Models/homepage/temperature_humidity_model.dart';



class TemperatureHumidityController {
  Future<TemperatureHumidity> fetchLastTemperatureHumidity(String deviceId) async {
    final url = 'http://192.168.1.150:5000/tempguard/user/devices/iHUAsursTMccEbi3gYQ6wQ/$deviceId'; // Replace with the actual API endpoint for retrieving the last data.
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData is List) {
        // Handle the scenario when the server returns an array.
        // You might want to select the last item in the list or handle it based on your specific use case.
        final lastData = jsonData.last;

        print('jsonData: $jsonData');



        return TemperatureHumidity.fromJson(lastData);
      } else if (jsonData is Map<String, dynamic>) {
        // Handle the scenario when the server returns an object.
        return TemperatureHumidity.fromJson(jsonData);
      } else {
        throw Exception('Invalid data format');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
