import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/authentication/login_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';



class LogInController {
  final String apiUrl; // Replace this with your actual API endpoint URL.

  LogInController(this.apiUrl);

  Future<Map<String, dynamic>> login(LogInData data) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data.toJson());

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

      if (response.statusCode == 200) {
        // Successful login, parse the response body to get the token
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['token'] as String;

        // Decode the token to get user information
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final id_user = decodedToken['id_user']; // Replace 'userid' with the actual field name

        return {
          'success': true,
          'token': token,
          'id_user': id_user,
        };
      } else {
        // Handle other status codes (e.g., 400, 500) and display appropriate messages to the user.
        print('Failed to log in : ${response.statusCode}');
        return {
          'success': false,
          'token': null,
          'id_user': null,
        };
      }
    } catch (e) {
      // Handle any network or server errors.
      print('Error logging in : $e');
      return {
        'success': false,
        'token': null,
        'id_user': null,
      };
    }
  }



}
