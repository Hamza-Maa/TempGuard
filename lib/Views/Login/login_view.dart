import 'package:flutter/material.dart';
import '../SignUp/signup_view.dart';
import '../device/DevicesList_view.dart';
import 'ForgetPassword_view.dart';
import 'package:tempguard_flutter_app/Controllers/authentication/login_controller.dart';
import 'package:tempguard_flutter_app/Models/authentication/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool areFieldsFilled = false;
  LogInController _logInController =
  LogInController('http://192.168.1.150:5000/tempguard/login'); // Replace with your actual API endpoint URL.



  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers to track field states
    _emailController.addListener(updateFieldsFilled);
    _passwordController.addListener(updateFieldsFilled);
  }

  void updateFieldsFilled() {
    setState(() {
      // Check if both email and password fields are filled
      areFieldsFilled =
          _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!areFieldsFilled) {
      return; // Prevent login if fields are not filled
    }

    String email = _emailController.text;
    String password = _passwordController.text;

    // Create a LogInData object to pass to the controller
    LogInData loginData = LogInData(email: email, password: password);


      // Call the login method in the controller
      Map<String, dynamic> response = await _logInController.login(loginData);

      if (response['success']) {
        final token = response['token'] as String;
        final userId = response['id_user'] as String;

        // Store token and user ID locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('id_user', userId);

        // Handle successful login.
        print('Login successful! Navigating to the Device screen...');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('You have successfully logged in!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => deviceList(), // Replace with the actual Device screen
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle login failure and show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to log in. Please check your credentials.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 90.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Container(
                    width: 180,
                    height: 170,
                    child: Image.asset('asset/Images/logo_login.png'),
                  ),
                  SizedBox(height: 10.0),
                  //first title
                  Text(
                    'Welcome to TempGuard',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //second title
                  Text(
                    'Enter your credentials to access your account.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF5A6385),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 30.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your email address',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF26326A),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  //input adress mail
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFD2D7DE),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF696969),
                            fontSize: 16.0,
                          ),
                          prefixIcon: Icon(
                            Icons.mail,

                          ),
                          filled: true,
                          fillColor: Color(0xFFF7F9FD),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF26326A),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  //input password
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFD2D7DE),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF696969),
                            fontSize: 16.0,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Color(0xFFF7F9FD),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 6,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color(0x99110D0D),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.0),

                  //button login
                  Container(
                    width: 194,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: areFieldsFilled ? _handleLogin : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF26326A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  //divider -OR-
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          indent: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Color(0x99110D0D),
                            fontSize: 13,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                          endIndent: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  //login with google button
                  Container(
                    width: 194,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF7F9FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0, left: 15.0),
                          child: Image.asset(
                            'asset/Images/Google.png',
                          ),
                        ),
                        Text(
                          'Log in with Google',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF26326A),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen()));

              },
              child: RichText(
                text: TextSpan(
                  text: 'Don’t have an account ?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0x99110D0D),
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF5A6385),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
