import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../Controllers/device/sharedevice_controller.dart';
import '../../Models/device/sharedevice_model.dart';
import 'package:tempguard_flutter_app/Controllers/device/devicelist_controller.dart';
import 'package:tempguard_flutter_app/Models/device/devicelist_model.dart';
import 'package:http/http.dart' as http;
import '../bottom_nav_bar_view.dart';
import 'addnewdevice1_view.dart';
import 'package:tempguard_flutter_app/Controllers/device/sharedinfo_controller.dart'; // Import the sharedinfo_controller
import 'package:tempguard_flutter_app/Models/device/sharedinfo_model.dart'; // Import the sharedinfo_controller
import 'package:shared_preferences/shared_preferences.dart';



class deviceList extends StatefulWidget {
  @override
  State<deviceList> createState() => _deviceListState();
}


class _deviceListState extends State<deviceList> {


  final _sharedinfoController = sharedinfoController();




  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_user');
  }

  late String access_write = '';

  List<bool> selectedStates =
      []; // A list of boolean values that determine whether each device item is selected.

  bool showCheckboxes =
      false; // A boolean indicating whether checkboxes should be shown for each device item that is set as false in this case

  bool masterCheckboxValue =
      false; //: A boolean indicating the state of the "Select All" checkbox. that is set as false in this case

  bool get isCheckboxChecked => selectedStates.contains(
      true); //A getter that returns true if any device item is selected.

  Color selectedColor = Color(0xFF26326A);
  Color unselectedColor = Colors.grey;
  int _currentIndex = 2;


  TextEditingController _mailController = TextEditingController();

  final _sharedevicecontroller = sharedeviceController('http://192.168.1.150:5000/tempguard/device/share/iHUAsursTMccEbi3gYQ6wQ');



  void _handlesharedevice() async {
    final email = _mailController.text;

    String? id_user = await getUserId();

    if (id_user != null) {
      final sharedeviceData = SharedeviceData(
        email: email,
        access_write: access_write,
        id_user: id_user,
        id_device: selecteddevice.id_device,
      );


      try {
        final response = await _sharedevicecontroller.sharedevice(sharedeviceData);

        if (response == 201) {
          // Handle successful share device.
          print('Share device successful! Navigating to the log in screen...');

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('You have successfully shared the device!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Handle share device error.
          print('Share device error');

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Failure'),
              content: Text('User is not found!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );


          // Show an error message to the user.
        }    } catch (error) {
        // Handle share device error.
        print('Share device error: $error');
        // Show an error message to the user.
      }
    }
    else {
      // Handle the case where userId is null.
      print('User ID is null');
      // Show an error message to the user or take appropriate action.
    }
  }






  @override
  void dispose() {
    _mailController.dispose();

    super.dispose();
  }
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
        "Devices List",
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

  // A method that builds the header displaying the total number of devices.
  Widget buildHeader(int deviceCount) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenWidth * 0.04, 18, 0, 0),
      child: Row(
        children: [
          Text(
            'You Have total of $deviceCount ${deviceCount == 1 ? 'device' : 'device'}',
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
  devicelistdata selecteddevice = new devicelistdata(
      id_device: "id_device", temperature: 0, humidity: 0, battery: 0, status_device: "on");

//---------------------------
  Widget builddeviceContainer(devicelistdata data, int index) {
    return GestureDetector(
      onLongPress: () {
        if (mounted) {
        setState(() {
          showCheckboxes = true;
          selectedStates[index] = !selectedStates[index];
          selectedIndex = [];
          for (int i = 0; i < selectedStates.length; i++) {
            if (selectedStates[i]) {
              devicelistdata temp = deviceDataList[i];
              selectedIndex.add(temp.id_device);
            }
          }

          if (selectedStates.where((isSelected) => isSelected).length == 1) {
            devicelistdata temp = deviceDataList[0];
            selecteddevice = temp;
          }
        });}
      },
      child: Container(
        width: 400,
        height: 130,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedStates[index] ? Color(0xFF8EBAFC) : Color(0xFFF7F9FD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
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

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'device: ${data.id_device}',
                  style: TextStyle(
                    color: Color(0xFF264A6A),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'temperature: ${data.temperature}°C',
                  style: TextStyle(
                    color: Color(0xFF264A6A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'humidity: ${data.humidity}%',
                  style: TextStyle(
                    color: Color(0xFF264A6A),
                  ),
                ),
                Text(
                  'status: ${data.status_device}',
                  style: TextStyle(
                    color: Color(0xFF264A6A),
                    fontSize: 14,
                  ),
                ),
                FutureBuilder<List<sharedinfodata>>(
                  future: _sharedinfoController.fetchsharedinfoList(data.id_device),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading shared info');
                    } else if (snapshot.hasData) {
                      final sharedInfoList = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: sharedInfoList.map((sharedInfo) {
                          return Text(
                            'Shared User: ${sharedInfo.username}, Email: ${sharedInfo.email_adress}',
                            style: TextStyle(
                              color: Color(0xFF264A6A),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Text('No shared info available');
                    }
                  },
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
//--------------------------







  List<Widget> deviceContainers = [];
  late Widget headerWidget = Container();
  List<devicelistdata> deviceDataList = [];

  Future<void> retrievedevice() async {
    final controller = devicelistController();
    // fetch list from db
    deviceDataList = await controller.fetchdeviceList();

    // Initialize selectedStates list with false values
    selectedStates = List.generate(deviceDataList.length, (index) => false);

    // Clear previous device containers
    deviceContainers.clear();

    // for loop to display list of devices
    for (int index = 0; index < deviceDataList.length; index++) {

      Widget deviceContainer = builddeviceContainer(deviceDataList[index], index);
      deviceContainers.add(deviceContainer);
    }

    // show device count
    int deviceCount = deviceDataList.length;
    if (mounted) {
    setState(() {
      headerWidget = buildHeader(deviceCount);
    });}
  }

  Future<void> deletedevice(List<String> ids) async {
    try {
      for (String id_device in ids) {
        final response = await http.delete(Uri.parse(
            'http://192.168.1.150:5000/tempguard/user/$id_device'));

        if (response.statusCode == 200) {
          // Remove the deleted device from the local list
          deviceDataList.removeWhere((device) => device.id_device == id_device);
          // Update the selectedStates list accordingly
          //  selectedStates.removeAt(id_device- 1); // Assuming IDs are 1-based
          retrievedevice();
        } else {
          print('Error deleting device. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error deleting device: $e');
    }
  }

//An overridden method called when the widget is first created
  @override
  void initState() {
    super.initState();
    retrievedevice();
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
                List.generate(deviceContainers.length, (index) => false);
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
                                deviceContainers.length,
                                (index) => value,
                              );
                              selectedIndex = [];
                              for (int i = 0; i < selectedStates.length; i++) {
                                if (selectedStates[i]) {
                                  devicelistdata temp = deviceDataList[i];
                                  selectedIndex.add(temp.id_device);
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
                    ...deviceContainers,
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
                    if (selectedStates.where((isSelected) => isSelected).length == 1)
                      SpeedDialChild(
                        labelShadow: [],
                        elevation: 0,
                        child: Icon(Icons.edit, color: Colors.white),
                        backgroundColor: Colors.blue,
                        onTap: () {
                          // Handle edit action
                        },
                        label: 'Edit',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        labelBackgroundColor: Colors.blue,
                      ),
                    if (selectedStates.where((isSelected) => isSelected).length == 1)
                      SpeedDialChild(
                        labelShadow: [],
                        elevation: 0,
                        child: Icon(Icons.ios_share_outlined, color: Colors.white),
                        backgroundColor: Color(0xFF264A6A),
                        onTap: () {
                          // Handle export action
                        },
                        label: 'Export',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        labelBackgroundColor: Color(0xFF264A6A),
                      ),
                    SpeedDialChild(
                      labelShadow: [],
                      elevation: 0,
                      child: Icon(Icons.delete, color: Colors.white),
                      backgroundColor: Colors.red,
                      onTap: () {
                        // Handle delete action
                      },
                      label: 'Delete',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      labelBackgroundColor: Colors.red,
                    ),
                    SpeedDialChild(
                      labelShadow: [],
                      elevation: 0,
                      child: Icon(Icons.share_outlined, color: Colors.white),
                      backgroundColor: Colors.lightGreen,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Enter mail to share device '),
                            content: Column(
                              children: [
                                TextField(
                                  controller: _mailController,
                                  decoration: InputDecoration(labelText: 'Email'),
                                ),
                                MyDropdown(
                                  dropdownOptions: ['viewer', 'writer'],
                                  titleText: 'DEVICE',
                                  onChanged: (value) {
                                   if (mounted) {
                                    setState(() {
                                      access_write = value!;
                                    });}
                                  },
                                ),

                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the popup
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: _handlesharedevice,
                                child: Text('Confirm'),
                              ),
                            ],                          ),
                        );

                        // Handle delete action
                      },
                      label: 'share',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      labelBackgroundColor: Colors.green,
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
                      MaterialPageRoute(builder: (context) => adddevice()),
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

class MyDropdown extends StatefulWidget {
  final List<String> dropdownOptions;
  final String titleText;
  final Function(String?)? onChanged;

  const MyDropdown({
    Key? key,
    required this.dropdownOptions,
    required this.titleText,
    this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.dropdownOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleText,
            style: const TextStyle(
              color: Color(0xFF26326A),
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xFFF5F5F5),
            ),
            child: DropdownButton<String>(
              value: selectedOption,
              borderRadius: BorderRadius.circular(10.0),
              dropdownColor: const Color(0xFFF5F5F5),
              elevation: 8,
              style: const TextStyle(
                color: Color(0xFF696969),
                fontSize: 16.0,
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFFD9D9D9),
              ),
              iconSize: 50,
              isExpanded: true,
              underline: Container(),
              items: widget.dropdownOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(option),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (mounted) {
                setState(() {
                  selectedOption = newValue!;
                });}
                widget.onChanged?.call(newValue);
              },
              hint: Text(
                widget.titleText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
