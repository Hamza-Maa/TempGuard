import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:tempguard_flutter_app/Views/alarme/setalarme_view.dart';

import '../../Controllers/alert/AlertList_controller.dart';
import '../../Models/alert/AlertList_model.dart';
import '../bottom_nav_bar_view.dart';
import 'modifyalarme_view.dart';

class AlertsList extends StatefulWidget {
  const AlertsList({Key? key}) : super(key: key);

  @override
  _AlertsListState createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {

  List<bool> selectedStates =
      []; // A list of boolean values that determine whether each alert item is selected.

  bool showCheckboxes =
      false; // A boolean indicating whether checkboxes should be shown for each alert item that is set as false in this case

  bool masterCheckboxValue =
      false; //: A boolean indicating the state of the "Select All" checkbox. that is set as false in this case

  bool get isCheckboxChecked => selectedStates.contains(
      true); //A getter that returns true if any alert item is selected.

  Color selectedColor = Color(0xFF26326A);
  Color unselectedColor = Colors.grey;
  int _currentIndex = 1;

  void _onNavItemTapped(int index) {
    if (mounted) {

      setState(() {
      _currentIndex =
          index; //: An integer representing the index of the current bottom navigation bar item.
    });}
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 60,
      title: Text(
        "Alerts List",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: const Color(0xFF26326A),
      elevation: 0,
    );
  }
  // A method that builds the header displaying the total number of alerts.
    buildHeader(int alertCount) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidth * 0.04, 18, 0, 0),
      child: Row(
        children: [
          Text(
            'You Have total of $alertCount ${alertCount == 1 ? 'Alert' : 'Alerts'}',
            style: TextStyle(
              fontSize: 20,
              color: const Color(0xFF26326A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  List<String> selectedIndex = [];
  alertlistdata selectedAlert = new alertlistdata(
      id_device: "id_device",
      id_alert: "id_alert",
      indicator: "indicator",
      minValue: 0,
      maxValue: 0,
      notif_type: "notif_type");

//









  Widget buildAlertContainer(alertlistdata data, int index) {

      return GestureDetector(
        onLongPress: () {
          if (mounted) {

            setState(() {
            showCheckboxes = true; // Set showCheckboxes to true
            selectedStates[index] = !selectedStates[index];
            selectedIndex = [];
            for (int i = 0; i < selectedStates.length; i++) {
              if (selectedStates[i]) {
                alertlistdata temp = alertDataList[i];
                selectedIndex.add(temp.id_alert);
              }
            }

            if (selectedStates
                .where((isSelected) => isSelected)
                .length == 1) {
              alertlistdata temp = alertDataList[0];
              selectedAlert = temp;
            }
          });}
        },
        child: Container(
          width: 400,
          height: 130,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selectedStates[index] ? Color(0xFF8EBAFC) : Color(
                0xFFF7F9FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            // Wrap the Container contents with a Row
            children: [
              Checkbox(
                value: selectedStates[index],
                onChanged: (value) {
                  if (mounted) {

                    setState(() {
                    selectedStates[index] = !selectedStates[index];
                  });}
                },
              ),
              SizedBox(width: 10),
              // Add some spacing

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(

                    'Alert: ${data.id_device}',
                    style: TextStyle(
                      color: Color(0xFF264A6A),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'INDICATOR: ${data.indicator}',
                    style: TextStyle(
                      color: Color(0xFF264A6A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Alert Type: ${data.notif_type}',
                    style: TextStyle(
                      color: Color(0xFF264A6A),
                    ),
                  ),
                  Text(
                    'Min: ${data.minValue}°C',
                    style: TextStyle(
                      color: Color(0xFF264A6A),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Max: ${data.maxValue}°C',
                    style: TextStyle(
                      color: Color(0xFF264A6A),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),




              if (showCheckboxes && selectedStates[index])
                Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 24,
                ),
            ],
          ),
        ),
      );

  }
  List<Widget> alertContainers = [];
  late Widget headerWidget = Container();
  List<alertlistdata> alertDataList = [];

  Future<void> retrieveAlerts() async {
    final controller = alertlistController();
    // fetch list from db
    alertDataList = await controller.fetchAlertList();

    // Initialize selectedStates list with false values
    selectedStates = List.generate(alertDataList.length, (index) => false);

    // Clear previous alert containers
    alertContainers.clear();

    // for loop to display list of alerts
    for (int index = 0; index < alertDataList.length; index++) {
      Widget alertContainer = buildAlertContainer(alertDataList[index], index);
      alertContainers.add(alertContainer);
    }

    // show alert count
    int alertCount = alertDataList.length;
    if (mounted) {

      setState(() {
      headerWidget = buildHeader(alertCount);
    });}
  }

  Future<void> deleteAlert(List<String> ids) async {
    try {
      for (String id_alert in ids) {
        final response = await http.delete(Uri.parse(
            'http://192.168.1.150:5000/tempguard/device/alerts/iHUAsursTMccEbi3gYQ6wQ/$id_alert'));


        if (response.statusCode == 200) {
          // Remove the deleted alert from the local list
          alertDataList.removeWhere((alert) => alert.id_alert == id_alert);
          // Update the selectedStates list accordingly
          //  selectedStates.removeAt(id_alert - 1); // Assuming IDs are 1-based
          retrieveAlerts();
        } else {
          print('Error deleting alert. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error deleting alert: $e');
    }
  }

//An overridden method called when the widget is first created
  @override
  void initState() {
    super.initState();
    retrieveAlerts();
  }

  @override
  Widget build(BuildContext context) {
    int checkedCount = selectedStates.where((selected) => selected).length;

    return WillPopScope(
      onWillPop: () async {
        if (showCheckboxes) {
          if (mounted) {

            setState(() {
            showCheckboxes = false;
            selectedStates =
                List.generate(alertContainers.length, (index) => false);
          });}
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    headerWidget,
                    if (showCheckboxes)
                      ListTile(
                        leading: Checkbox(
                          value: masterCheckboxValue,
                          onChanged: (value) {
    if (mounted) {

    setState(() {
                              masterCheckboxValue = value!;
                              selectedStates = List.generate(
                                alertContainers.length,
                                (index) => value,
                              );
                              selectedIndex = [];
                              for (int i = 0; i < selectedStates.length; i++) {
                                if (selectedStates[i]) {
                                  alertlistdata temp = alertDataList[i];
                                  selectedIndex.add(temp.id_alert);
                                }
                               }
                            });}
                          },
                          activeColor: Color(0xFF26326A),
                        ),
                        title: Text(
                          'Select All',
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Text(
                          '$checkedCount Checked',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ...alertContainers,
                    SizedBox(height: 80),
                  ],
                ),
              ),
              Positioned(
                bottom: 90.0,
                right: 16.0,
                child: SpeedDial(
                  visible: isCheckboxChecked,
                  animatedIcon: AnimatedIcons.menu_close,
                  backgroundColor: Color(0xFF6C768D),
                  elevation: 0,
                  children: [
                    if (selectedStates
                            .where((isSelected) => isSelected)
                            .length == 1)
                      SpeedDialChild(
                        labelShadow: [],
                        elevation: 0,
                        child: Icon(Icons.edit, color: Colors.white),
                        backgroundColor: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    modifyAlert(entity: selectedAlert)),
                          );
                        },
                        label: 'Edit',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        labelBackgroundColor: Colors.blue,
                      ),
                    SpeedDialChild(
                      labelShadow: [],
                      elevation: 0,
                      child: Icon(Icons.delete, color: Colors.white),
                      backgroundColor: Colors.red,
                      onTap: () {
                        deleteAlert(selectedIndex);
                      },
                      label: 'Delete',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      labelBackgroundColor: Colors.red,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: SpeedDial(
                  animatedIcon: AnimatedIcons.add_event,
                  backgroundColor: Color(0xFF26326A),
                  elevation: 0,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetNewAlert()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
        ),
      ),
    );
  }
}
