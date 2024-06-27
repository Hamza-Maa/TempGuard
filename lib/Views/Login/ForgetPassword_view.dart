import 'package:flutter/material.dart';

import 'ResetPassword_view.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //arrow back
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_left_outlined, size: 50, color: Color(0xFF26326A)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.only(top: 55, left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('asset/Images/forget_password.png'),
                    SizedBox(height: 80),
                    Text(
                      'Forgot your password?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF171932),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please enter your email address associated with your account to reset your password.',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF171932),
                        fontSize: 12,

                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      'Your email address',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF26326A),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 370,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFD2D7DE),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder( // Use OutlineInputBorder instead of InputBorder.none
                            borderRadius: BorderRadius.circular(15.0), // Match the container's border radius
                            borderSide: BorderSide.none, // Remove the border side
                          ),
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF696969),
                            fontSize: 16.0,
                          ),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Color(0xFF26326A),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF7F9FD),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),

                  ],
                ),

              ),
              SizedBox(height: 15.0),

              Container(

                width: 194,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF26326A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),


              // Add your other content here
            ],
          ),
        ),
      ),
    );
  }
}
