import 'package:flutter/material.dart';
import 'Views/SignUp/signup_view.dart';
import 'Views/homepage/homepage_view.dart';
import 'Views/Login/login_view.dart';
import 'package:tempguard_flutter_app/Views/notification/pushnotification_view.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:tempguard_flutter_app/Services/notification_listner.dart';
import 'Views/OnBoarding/onboarding_view.dart';




void main() {

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService();
    final pushNotificationObserver = PushNotificationObserver(notificationService);

    // Start listening for notifications
    notificationService.startListeningForNotifications((notification) {
      // Handle the received notification
      // You can display a dialog, show a notification, etc.
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:onboarding(),
    );

  }

}