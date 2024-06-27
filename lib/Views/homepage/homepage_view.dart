import 'dart:async';
import 'package:flutter/material.dart';
import '../../Controllers/homepage/temperature_humidity_controller.dart';
import '../../Controllers/homepage/line_chart_controller.dart';
import '../bottom_nav_bar_view.dart';
import 'chart_view.dart';
import 'topslider_view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> deviceIds = [];


  String _currentDeviceId = ''; // Store the current device ID
  String _temperature = '...';
  String _humidity = '...';
  int _battery = 0;
  LineChartController? lineChartController;

  @override
  void initState() {
    super.initState();
    _currentDeviceId = deviceIds[0]; // Initialize with the first device ID
    _fetchDataForCurrentDevice();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Timer.periodic(Duration(seconds: 5), (_) {
        _fetchDataForCurrentDevice();
      });
    });
  }

  void _fetchDataForCurrentDevice() {
    _fetchTemperatureHumidity(_currentDeviceId);

    // Initialize lineChartController before calling fetchData
    lineChartController = LineChartController(apiUrl: 'http://192.168.1.150:5000/tempguard/devices');

    // Assuming you have fetched deviceIds from the database and assigned them to deviceIds list
    if (deviceIds.isNotEmpty) {
      String selectedDeviceId = deviceIds[_currentIndex]; // Use the selected index
      lineChartController!.fetchData(selectedDeviceId, () {
        setState(() {
          // This callback is executed when the data is fetched and needs a widget rebuild.
        });
      });
    }
  }



  void _fetchTemperatureHumidity(String deviceId) {
    final controller = TemperatureHumidityController();

    controller.fetchLastTemperatureHumidity(deviceId).then((temperatureHumidity) {
      setState(() {
        _temperature = '${temperatureHumidity.temperature} ';
        _humidity = '${temperatureHumidity.humidity} ';
        _battery = temperatureHumidity.battery;
      });
    }).catchError((error) {
      print('Error fetching data: $error');
    });
  }
  List<String> notifications = [
    'Notification title   ',
    'Notification title',
    'Notification title',
    'Notification title'
  ];


  int _currentIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      title: Image.asset('asset/logo.png', width: 80),
      backgroundColor: const Color(0xFF26326A),
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: PageView.builder(
        itemCount: deviceIds.length,
        itemBuilder: (context, index) {
          final deviceId = deviceIds[index];
          _currentDeviceId = deviceId;
          _fetchDataForCurrentDevice();

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Positioned(
                      child: Container(
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
                        child: TopSlider(battery: _battery, deviceId: _currentDeviceId),

                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: 150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, -4),
                            ),
                          ],
                          color: Color(0xFF0096DC),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'TEMPERATURE',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat-bold'),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  ' $_temperature°C',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Montserrat-bold',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            VerticalDivider(
                              color: Colors.white,
                              thickness: 5,
                              indent: 10,
                              endIndent: 0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'HUMIDITY',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Montserrat-bold',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '$_humidity%',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Montserrat-bold',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 5,
                      right: 5,
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(20, 55, 0, 0),
                                  child: Text(
                                    'CHARTS',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Color(0xFF26326A),
                                        fontFamily: 'Montserrat-bold'),
                                  ),
                                ),
                                /*    Container(
                              padding: const EdgeInsets.fromLTRB(170, 50, 0, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor: Color(0xFFE9EEF9),
                                ),
                                onPressed: () {
                                  // Add your onPressed logic here
                                },
                                child: Text(
                                  'EXPORT',
                                  style: TextStyle(
                                    color: const Color(0xFF26326A),
                                    fontSize: 15,
                                    fontFamily: 'Montserrat-bold',
                                  ),
                                ),
                              ),
                            ),*/
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 366,
                              width: 400,
                              child: lineChartController != null
                                  ? LineChartWidget(controller: lineChartController!)
                                  : CircularProgressIndicator(), // Display loading indicator if lineChartController is null
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(9, 0, 190, 0),
                              child: Text(
                                'NOTIFICATIONS',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF26326A),
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: notifications.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF7F9FD),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        notifications[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF26326A),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (lineChartController != null)
                  LineChartWidget(controller: lineChartController!),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}

