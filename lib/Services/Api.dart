import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl;

  ApiService(this._baseUrl);



  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$_baseUrl/tempguard'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> postData(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/tempguard'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}


