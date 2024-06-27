import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tempguard_flutter_app/Models/alert/AlertList_model.dart';

import '../../Models/alert/setalarme_model.dart'; // Use the correct casing here

class AlertController {
  final String apiUrl;

  AlertController(this.apiUrl);

  Future<void> saveAlert(alertlistdata AlertData) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(AlertData.toJson());

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 201) {
        // Success! Handle the response if needed.

        print('Sign up successful!');
      } else {
        // Handle other status codes and display appropriate messages to the user.
        print('Failed to send alert: ${response.statusCode}');
        // Optionally, you can check the response body for more information:
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any network or server errors.
      print('Error sending alert: $e');
    }
  }
}
