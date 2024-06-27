import 'package:flutter/material.dart';

class TopSlider extends StatefulWidget {
  final int battery;
  final String deviceId; // Add this variable

  const TopSlider({Key? key, required this.battery, required this.deviceId})
      : super(key: key);

  @override
  State<TopSlider> createState() => _TopSliderState();
}

class _TopSliderState extends State<TopSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
          color: Color(0xFF0096DC),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.rotate(
              angle: 90 * 3.1415926535 / 180,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 60,
              ),
            ),
            Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  'Device ${widget.deviceId}', // Display the deviceId
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Montserrat-bold',
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.battery}%',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: widget.battery < 15 ? Colors.red : Colors.white,
                      ),
                    ),
                    Transform.rotate(
                      angle: 90 * 3.1415926535 / 180,
                      child: Icon(
                        widget.battery < 15 ? Icons.battery_alert : Icons.battery_6_bar,
                        color: widget.battery < 15 ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Transform.rotate(
              angle:  -90* 3.1415926535 / 180,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
