import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'profile_view.dart';


import '../bottom_nav_bar_view.dart';

import 'aboutus_view.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkModeEnabled = false;
  String currentLanguage = 'English';
  int _currentIndex = 4;

  bool isNotificationsSoundEnabled = true;

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
        "Settings",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat-bold',
        ),
      ),
      backgroundColor: const Color(0xFF26326A),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                    title: "Profil",
                    icon: CupertinoIcons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                  ),
                  _CustomListTile(
                    title: "Languages",
                    icon: Icons.language,
                    onTap: () {
                      // Handle Languages tile click
                    },
                  ),
                  _CustomListTile(
                    title: "Dark Mode",
                    icon: CupertinoIcons.moon,
                    trailing: CupertinoSwitch(
                      value: isDarkModeEnabled,
                      onChanged: (value) {
                        setState(() {
                          isDarkModeEnabled = value;
                        });
                      },
                      activeColor: Color(0xFF26326A),
                    ),
                    onTap: () {
                      // Handle Dark Mode tile click
                    },
                  ),
                ],
              ),

              _SingleSection(
                title: "More",
                children: [
                  _CustomListTile2(
                    title: "About Us",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutUs()),
                      );
                    },
                  ),

                  _CustomListTile2(
                    title: "Privacy Policy",
                    onTap: () {
                      // Handle Privacy Policy tile click
                    },
                  ),
                  _CustomListTile2(
                    title: "Terms And Conditions",
                    onTap: () {
                      // Handle Terms And Conditions tile click
                    },
                  ),
                ],
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

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback onTap;

  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style:TextStyle(fontFamily: 'Montserrat',),),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: onTap,
    );
  }
}

class _CustomListTile2 extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _CustomListTile2({
    Key? key,
    required this.title,
    this.trailing,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
