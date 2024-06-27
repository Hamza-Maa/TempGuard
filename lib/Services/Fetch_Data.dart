import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/homepage/temperature_humidity_model.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<T> fetchData<T>(String endpoint, T Function(dynamic) dataParser) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return dataParser(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<TemperatureHumidity> fetchTemperatureHumidity() async {
    return fetchData('users', (jsonData) {
      // Assuming jsonData is a list, we'll take the first item from the list
      if (jsonData is List && jsonData.isNotEmpty) {
        return TemperatureHumidity.fromJson(jsonData[1]);
      } else {
        throw Exception('Invalid data format for TemperatureHumidity');
      }
    });
  }

// Add more methods for fetching other types of data if needed
}
