import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const TextStyle labelStyle = TextStyle(
  color: Color(0xFF26326A),
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

const TextStyle hintStyle = TextStyle(
  color: Color(0xFF696969),
  fontSize: 16.0,
);

class ProfileScreen extends StatelessWidget {

  Future<void> updateProfileData(String username, String email, String phone_Number, String password) async {
    final url = 'http://192.168.1.150:5000/tempguard/user/iHUAsursTMccEbi3gYQ6wQ';

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'phone_number': phone_Number,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Profile data updated successfully
      print('Profile data updated');
    } else {
      // Error updating profile data
      print('Error updating profile data');
    }
  }


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String getUsernameValue() {
    return usernameController.text;
  }

  String getEmailValue() {
    return emailController.text;
  }

  String getPhoneNumberValue() {
    return phoneNumberController.text;
  }

  String getPasswordValue() {
    return passwordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF26326A),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 95),
                          child: Text(
                            'Edit Profil',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  height: 400,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('asset/profil.png'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 290, left: 10, right: 10),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'change picture',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    buildTextField(
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                      hintText: ' username',
                      controller: usernameController,

                    ),
                    SizedBox(height: 8.0),
                    buildTextField(
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                      hintText: 'Email',
                      controller: emailController,

                    ),
                    SizedBox(height: 8.0),
                    buildTextField(
                      labelText: 'Phone Number',
                      prefixIcon: Icons.phone,
                      hintText: 'Phone Number',
                      controller: phoneNumberController,

                    ),
                    SizedBox(height: 8.0),
                    buildTextField(
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      hintText: 'Password',
                      controller: passwordController,

                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      child: Text('Update'),
                      onPressed: () {
                        final username = getUsernameValue(); // Implement this to get the username value from the text field
                        final email = getEmailValue();       // Implement this to get the email value from the text field
                        final phone_Number = getPhoneNumberValue(); // Implement this to get the phone number value from the text field
                        final password = getPasswordValue(); // Implement this to get the password value from the text field

                        updateProfileData(username, email, phone_Number, password);
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(194.0, 36.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF0096DC),
                        ),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTextField({
  required String labelText,
  required IconData prefixIcon,
  required String hintText,
  required TextEditingController controller,



}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        labelText,
        style: labelStyle,
      ),
      SizedBox(height: 4.0),
      Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD2D7DE),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: Color(0xFF26326A),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Color(0xFFF7F9FD),
            hintText: hintText,
            hintStyle: hintStyle,
          ),
        ),
      ),
    ],
  );
}
