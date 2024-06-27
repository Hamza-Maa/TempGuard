import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class AboutUs extends StatelessWidget {
  static const Color kPrimaryColor = Color(0xFF26326A);
  static const Color kSecondaryColor = Color(0xFF5A6385);
  static const Color kBackgroundColor = Colors.white;
  static const Color kDividerColor = Color(0xFFECEFF4);

  static const double kIconSize = 40.0;
  static const double kArrowIconSize = 60.0;
  static const double kContainerWidth = 350.0;
  static const double kContainerHeight1 = 423.0;
  static const double kContainerHeight2 = 270.0;

  static const String kAssetPath = 'asset/Images/';
  static const String kLogoPath = kAssetPath + 'asqii.black.png';
  static const String kLinkedInPath = kAssetPath + 'linkedin.png';
  static const String kMailPath = kAssetPath + 'mail.png';
  static const String kGlobePath = kAssetPath + 'globe.png';

  static const String kLinkedInURL = 'https://www.linkedin.com/company/asqii/';
  static const String kMailURL = 'mailto:contact@asqii.tn';
  static const String kWebsiteURL = 'https://asqii.tn/';

  Future<void> _launchURL(String url) async {
    try {
      if (await launcher.canLaunch(url)) {
        await launcher.launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Fallback option: Open the URL in a web browser
      await launcher.launch(url, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 100.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Transform.rotate(
                            angle: 90 * 3.1415926535 / 180,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: kArrowIconSize,
                            ),
                          ),
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: kContainerHeight1,
                width: kContainerWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 230.0, top: 20.0),
                      child: Image.asset(
                        kLogoPath,
                        width: 100.0,
                        height: 80.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'ASQII',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                    Text(
                      'ASQII is a startup specialized in Healthtech solutions, founded in 2021. We have obtained the "StartupAct" label and participated in several incubators. We have been involved in several projects related to digitalization, data analysis, and process automation in the healthcare field.',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: kSecondaryColor,
                      ),
                    ),
                    SizedBox(height: 23,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Text(
                        'Here are our contact',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: kContainerHeight2,
                width: kContainerWidth,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(width: 50.0),
                            Image.asset(
                              kLinkedInPath,
                              width: kIconSize,
                              height: kIconSize,
                            ),
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Linkedin',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'ASQII',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _launchURL(kLinkedInURL);
                              },
                              child: Icon(
                                Icons.chevron_right,
                                size: kIconSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      color: kDividerColor,
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(width: 50.0),
                            Image.asset(
                              kMailPath,
                              width: kIconSize,
                              height: kIconSize,
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Adress mail',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Send us an e-mail',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _launchURL(kMailURL);
                              },
                              child: Icon(
                                Icons.chevron_right,
                                size: kIconSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      color: kDividerColor,
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(width: 50.0),
                            Image.asset(
                              kGlobePath,
                              width: kIconSize,
                              height: kIconSize,
                            ),
                          ],
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Web Site',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Discover our website',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _launchURL(kWebsiteURL);
                              },
                              child: Icon(
                                Icons.chevron_right,
                                size: kIconSize,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
