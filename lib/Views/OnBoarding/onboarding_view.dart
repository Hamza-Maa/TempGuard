import 'package:onboarding/onboarding.dart';
import 'package:flutter/material.dart';

import '../Login/login_view.dart';

class onboarding extends StatefulWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  State<onboarding> createState() => _MyAppState();
}

class _MyAppState extends State<onboarding> {

  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset('asset/Images/onbroading1.png',width: 250,height: 300,
                 ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Monitor real-time data with interactive line charts.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: const Color(0xFF000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

              ),
            ),


            SizedBox(height: 100,)

          ],
        ),
      ),
    ),
    PageModel(
      widget: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset('asset/Images/onbroading2.png',width: 250,height: 300,
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instantly scan QR codes with ease.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: const Color(0xFF000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    ),
    PageModel(
      widget: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Image.asset('asset/Images/onbroading3.png',width: 250,height: 300,
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Stay on top of things with comprehensive notifications.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: const Color(0xFF000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    ),

  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xFFE9EEF9),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),

          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => LoginPage()));

          },

        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'SKIP',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: const Color(0xFF110E0E),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xFFE9EEF9),

      child: InkWell(

        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => LoginPage()));

        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child:Text(
            'SKIP',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: const Color(0xFF110E0E),
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(

        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
              ),
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIndicator(
                      netDragPercent: dragDistance,
                      pagesLength: pagesLength,
                        indicator: Indicator(
                          activeIndicator: ActiveIndicator(
                            color: Colors.black,
                            borderWidth: 1,
                          ),
                          closedIndicator: ClosedIndicator(
                            color: Color(0xFF26326A),
                          ),
                          indicatorDesign: IndicatorDesign.polygon(
                            polygonDesign: PolygonDesign(
                              polygon: DesignType.polygon_circle,
                            ),
                          ),

                        )
                    ),
                    index == pagesLength - 1
                        ? _signupButton
                        : _skipButton(setIndex: setIndex)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
