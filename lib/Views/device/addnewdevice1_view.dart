import 'package:flutter/material.dart';
import 'DevicesList_view.dart';

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
class adddevice extends StatefulWidget {
  @override
  State<adddevice> createState() => _adddeviceState();
}

class _adddeviceState extends State<adddevice> {
  var submitTextStyle = TextStyle(
    fontSize: 28,
    letterSpacing: 5,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF26326A),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top:35),
                  child: Column(


                    children: [

                      Row(

                        children: [
                          Transform.rotate(
                            angle: 90 * 3.1415926535 / 180,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          Text(
                            "Add device",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100),
              Text(
                ' Choose a Wi-Fi network your device will use',
                style: TextStyle(
                  fontSize: 16,

                  color:Color(0xFF5A6385),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: buildTextField(
                  labelText: 'Wi-Fi',

                  hintText: 'Choose Wi-Fi Network',
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: buildTextField(
                  labelText: 'Password',

                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF26326A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),




            ],
          ),
        ),
      ),
    );
  }
}
Widget buildTextField({
  required String labelText,
  required String hintText,
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

