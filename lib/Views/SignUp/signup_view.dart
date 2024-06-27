import 'package:flutter/material.dart';
import '../../Controllers/authentication/Sign_Controller.dart';
import '../../Models/authentication/Sign_model.dart';
import '../Login/login_view.dart';

const Color primaryColor = Color(0xFF26326A);
const Color accentColor = Color(0xFF696969);
const Color backgroundColor = Color(0xFFF7F9FD);

const TextStyle labelStyle = TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);

const TextStyle hintStyle = TextStyle(
  color: accentColor,
  fontSize: 16.0,
);

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _controller = SignUpController('http://192.168.1.150:5000/tempguard/signup');

  bool areFieldsFilled = false; // New variable to track field states

  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers to track field states
    _usernameController.addListener(updateFieldsFilled);
    _emailController.addListener(updateFieldsFilled);
    _passwordController.addListener(updateFieldsFilled);
    _confirmPasswordController.addListener(updateFieldsFilled);
  }

  void updateFieldsFilled() {
    setState(() {
      // Check if all fields are filled
      areFieldsFilled = _usernameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  void _handleSignUp() {
    if (!areFieldsFilled) {
      return; // Prevent sign-up if fields are not filled
    }

    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      // Handle password mismatch error (optional).
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text("Passwords don't match!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final signUpData = SignUpData(
      username: username,
      email: email,
      password: password,
    );

    _controller.signUp(signUpData).then((_) {
      // Handle successful login.
      print('sign up successful! Navigating to the log in screen...');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('You have successfully signed up!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushReplacement( // Navigate to the Device screen
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(), // Replace with the actual Device screen
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      // Handle login error.
      print('sign up error: $error');
      // Show an error message to the user.
    });

  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 50.0,
          ),
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Image.asset('asset/Images/logo_login.png', height: 140),
              SizedBox(height: 16.0),
              Text(
                'Welcome to TempGuard',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                'First, create your account',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              buildTextField(
                labelText: 'Username',
                prefixIcon: Icons.person,
                hintText: 'Enter your username',
                controller: _usernameController,
              ),
              SizedBox(height: 8.0),
              buildTextField(
                labelText: 'Email',
                prefixIcon: Icons.email,
                hintText: 'Enter your email',
                controller: _emailController,
              ),
              SizedBox(height: 8.0),
              buildTextField(
                labelText: 'Password',
                prefixIcon: Icons.lock,
                hintText: 'Enter your password',
                obscureText: obscurePassword,
                controller: _passwordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Color(0xFF26326A),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              buildTextField(
                labelText: 'Confirm Password',
                prefixIcon: Icons.lock,
                hintText: 'Confirm your password',
                obscureText: obscureConfirmPassword,
                controller: _confirmPasswordController,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Color(0xFF26326A),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: areFieldsFilled ? _handleSignUp : null,
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(194.0, 40.0),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF26326A),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0x99110D0D),
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(
                        text: 'Log In',
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
      ),
    );
  }

  Widget buildTextField({
    required String labelText,
    required IconData prefixIcon,
    required String hintText,
    bool obscureText = false,
    Widget? suffixIcon,
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
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              prefixIcon: Icon(
                prefixIcon,
                color: Color(0xFF26326A),
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: backgroundColor,
              hintText: hintText,
              hintStyle: hintStyle,
            ),
          ),
        ),
      ],
    );
  }
}