import 'package:flutter/material.dart';
import 'package:tempguard_flutter_app/Services/notification_listner.dart';
import '../bottom_nav_bar_view.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<NotificationItem> notificationList = []; // List to store notifications

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    // Start listening for notifications
    notificationService.startListeningForNotifications((notificationItem) {
      // Handle the received notification
      // You can store it in a list and use it to build the notification widgets
      setState(() {
        // Add notificationItem to a list or handle as needed
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Stop listening for notifications when the widget is disposed
    notificationService.stopListening();
  }

  int _currentIndex = 3;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      title: Text(
        "Notifications",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat'
        ),
      ),
      backgroundColor: const Color(0xFF26326A),
      elevation: 0,
    );
  }

  Widget buildNotification(String title, String description, double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.125,
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
        color: Color(0xFFF7F9FD),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF26326A),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF5A6385),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.05),
              ListView.builder(
                shrinkWrap: true,
                itemCount: notificationList.length, // Replace with your list of notifications
                itemBuilder: (context, index) {
                  NotificationItem notification = notificationList[index];
                  return buildNotification(
                    notification.title,
                    notification.description,
                    screenHeight,
                    screenWidth,
                  );
                },
              ),
            ],
          ),

        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}
