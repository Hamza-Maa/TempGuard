import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Models/authentication/Sign_model.dart';

class SignUpController {
  final String apiUrl; // Replace this with your actual API endpoint URL.

  SignUpController(this.apiUrl);

  Future<void> signUp(SignUpData data) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data.toJson());

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 201) {
        // Success! Handle the response if needed.
        print('Sign up successful!');
      } else {
        // Handle other status codes and display appropriate messages to the user.
        print('Failed to sign up: ${response.statusCode}');
        // Optionally, you can check the response body for more information:
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle any network or server errors.
      print('Error signing up: $e');
    }
  }
}
