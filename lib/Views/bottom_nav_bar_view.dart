import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'Settings/Settings_view.dart';
import 'alarme/AlertsList_view.dart';
import 'device/DevicesList_view.dart';
import 'homepage/homepage_view.dart';
import 'notification/notification_view.dart';


class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {

  void onTap(int index) {
    if (index == widget.currentIndex) {
      // If the selected index is the same as the current index, do nothing
      return;
    }

    if (index == 0) {
      // Handle navigation for the Home screen with a fade transition
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          child: MainPage(),
        ),
      );
    } else if (index == 1) {
      //Handle navigation for the Alerts screen with a slide left transition
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          child: AlertsList(),
        ),
      );
    } else if (index == 2) {
      // Handle navigation for the Devices screen with a zoom transition
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          child: deviceList(),
        ),
      );

    } else if (index == 3) {
      // Handle navigation for the Notifications screen with a rotation transition
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          child: Notifications(),
        ),
      );
    } else if (index == 4) {
      // Handle navigation for the Settings screen with a slide up transition
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          child: SettingsScreen(),
        ),
      );
    }

    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF26326A),
      unselectedItemColor: Colors.grey,
      currentIndex: widget.currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'asset/Images/final_Alert.svg',
            height: 30,

            color: widget.currentIndex == 1 ? Color(0xFF26326A) : Colors.grey,
          ),
          label: 'Alerts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'Devices',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
