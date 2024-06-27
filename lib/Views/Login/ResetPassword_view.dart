import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _obscurePassword1 = true; // Variable to track password visibility for the first field
  bool _obscurePassword2 = true; // Variable to track password visibility for the second field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arrow Icon
              IconButton(
                icon: Icon(Icons.arrow_left_outlined, size: 50, color: Color(0xFF26326A)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 32.0),
              // Logo
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Image.asset('asset/Images/rest_pass.png', height: 350,), // Replace with your logo asset
                ),
              ),
              // New Password Text
              Text(
                'New Password',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF26326A),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.0),
              // New Password TextField
              _buildPasswordField(Icons.lock, _obscurePassword1, (value) {
                setState(() {
                  _obscurePassword1 = value;
                });
              }),
              SizedBox(height: 16.0),
              // Confirm Password Text
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xFF26326A),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.0),
              // Confirm Password TextField
              _buildPasswordField(Icons.lock, _obscurePassword2, (value) {
                setState(() {
                  _obscurePassword2 = value;
                });
              }),
              SizedBox(height: 30.0),
              // Reset Password Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement reset password logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF26326A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Rest Password',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(IconData icon, bool obscureText, ValueChanged<bool> onChanged) {
    return Container(
      width: 370,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFD2D7DE),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Enter your password',
          hintStyle: TextStyle(
            color: Color(0xFF696969),
            fontSize: 16.0,
          ),
          prefixIcon: Icon(
            icon,
            color: Color(0xFF26326A),
          ),
          filled: true,
          fillColor: Color(0xFFF7F9FD),
          suffixIcon: GestureDetector(
            onTap: () {
              onChanged(!obscureText);
            },
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Color(0xFF26326A),
            ),
          ),
        ),
      ),
    );
  }
}
