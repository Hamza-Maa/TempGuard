import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempguard_flutter_app/Controllers/alert/AlertList_controller.dart';
import 'package:tempguard_flutter_app/Models/alert/AlertList_model.dart';
import 'AlertsList_view.dart';

class modifyAlert extends StatefulWidget {
  @override
  _modifyAlertState createState() => _modifyAlertState();
  alertlistdata entity;

  modifyAlert({required this.entity});
}

class _modifyAlertState extends State<modifyAlert> {
  double _startValue = -10;
  double _endValue = 50;

  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startController = TextEditingController(text: _startValue.toString());
    _endController = TextEditingController(text: _endValue.toString());

    retrieveAlerts();
  }

  List<alertlistdata> alertDataList = [];
  List<String> deviceNames = ["Select Device"];

  Future<void> retrieveAlerts() async {
    final controller = alertlistController();
    // fetch list from db
    alertDataList = await controller.fetchAlertList();

    setState(() {
      deviceNames.addAll(alertDataList.map((alert) => alert.id_device).toList());
    });
  }

  Future<void> updateAlert(String id_alert) async {
    try {
      final headers = {'Content-Type': 'application/json'};

      final response = await http.put(
        Uri.parse(
            'http://192.168.1.150:5000/tempguard/device/alerts/iHUAsursTMccEbi3gYQ6wQ/$id_alert'),
        headers: headers,
        body: json.encode(widget.entity.toJson()),
      );

      if (response.statusCode == 200) {
        // Update the selectedStates list accordingly
        print("sucess");
      } else {
        print('Error modifying alert. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting alert: $e');
    }
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF26326A),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Transform.rotate(
                            angle: 90 * 3.1415926535 / 180,
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          Text(
                            'Modify Alert',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              MyDropdown(
                dropdownOptions: deviceNames,
                titleText: 'DEVICE',
                onChanged: (value) {
                  widget.entity.id_device = value!;
                },
              ),
              SizedBox(height: 20),
              MyDropdown(
                dropdownOptions: ['TEMPERATURE', 'HUMIDITY', 'BATTERY'],
                titleText: 'INDICATOR',
                onChanged: (value) {
                  widget.entity.indicator = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(right: 260, top: 30),
                child: Text(
                  'CONDITION',
                  style: TextStyle(
                    color: Color(0xFF26326A),
                    fontSize: 16.0,
                  ),
                ),
              ),
              RangeSliderExample(
                startValue: _startValue,
                endValue: _endValue,
                startController: _startController,
                endController: _endController,
                onRangeChanged: (start, end) {
                  setState(() {
                    _startValue = start;
                    _endValue = end;
                    widget.entity.minValue = start.toInt();
                    widget.entity.maxValue = end.toInt();
                  });
                },
              ),
              SizedBox(height: 30),

              MyCheckboxGroup(
                options: ['SMS', 'Mail'],
                titleText: 'ALERT TYPE',
                onChanged: (value) {
                  setState(() {
                    if (value.contains('SMS') && value.contains('Mail')) {
                      widget.entity.notif_type = 'both';
                    } else if (value.contains('SMS')) {
                      widget.entity.notif_type = 'sms';
                    } else if (value.contains('Mail')) {
                      widget.entity.notif_type = 'mail';
                    } else {
                      widget.entity.notif_type = ''; // No option selected
                    }
                  });
                },
              ),

              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  updateAlert(widget.entity.id_alert);
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AlertsList()))
                      .then((_) {
                    // Trigger the function after navigating to the page
                    (context as Element)
                        .markNeedsBuild(); // Forces a rebuild to call initState
                    // or you can directly call the function if you have a reference to the state
                    // DestinationPage().onPageLoad();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF26326A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Confirm Alert',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDropdown extends StatefulWidget {
  final List<String> dropdownOptions;
  final String titleText;
  final Function(String?)? onChanged; // New callback function parameter

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
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption =
        widget.dropdownOptions[0]; // Initialize with the first option
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
            style: TextStyle(
              color: Color(0xFF26326A),
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFFF5F5F5),
            ),
            child: DropdownButton<String>(
              value: selectedOption,
              borderRadius: BorderRadius.circular(10.0),
              dropdownColor: Color(0xFFF5F5F5),
              elevation: 8,
              style: TextStyle(
                color: Color(0xFF696969),
                fontSize: 16.0,
              ),
              icon: Icon(
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
                    padding: EdgeInsets.all(8.0),
                    child: Text(option),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
              hint: Text(
                widget.titleText,
                style: TextStyle(
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

class RangeSliderExample extends StatefulWidget {
  final double startValue;
  final double endValue;
  final TextEditingController startController;
  final TextEditingController endController;
  final void Function(double, double) onRangeChanged;

  RangeSliderExample({
    required this.startValue,
    required this.endValue,
    required this.startController,
    required this.endController,
    required this.onRangeChanged,
  });

  @override
  _RangeSliderExampleState createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  double min = -10;
  double max = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          RangeSlider(
            values: RangeValues(widget.startValue, widget.endValue),
            min: min,
            max: max,
            divisions: 60,
            onChanged: (values) {
              if (values.start <= values.end) {
                widget.onRangeChanged(values.start, values.end);
                widget.startController.text = values.start.toString();
                widget.endController.text = values.end.toString();
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Invalid Range'),
                    content: Text(
                        'The end value should be greater than or equal to the start value.'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Text(
                'min:',
                style: TextStyle(
                  color: Color(0xFF696969),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFFF7F9FD),
                  ),
                  child: TextFormField(
                    controller: widget.startController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Your onChanged logic
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF696969),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 100.0),
              Text(
                'max:',
                style: TextStyle(
                  color: Color(0xFF696969),
                  fontSize: 16.0,
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFFF7F9FD),
                  ),
                  child: TextFormField(
                    controller: widget.endController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Your onChanged logic
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xFF696969),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ],
      ),
    );
  }
}

class MyCheckboxGroup extends StatefulWidget {
  final List<String> options;
  final String titleText;
  final Function(List<String>) onChanged;

  MyCheckboxGroup({
    required this.options,
    required this.titleText,
    required this.onChanged,
  });

  @override
  _MyCheckboxGroupState createState() => _MyCheckboxGroupState();
}

class _MyCheckboxGroupState extends State<MyCheckboxGroup> {
  List<bool> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    selectedOptions = List.generate(widget.options.length, (index) => false);
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
          Column(
            children: List.generate(widget.options.length, (index) {
              return CheckboxListTile(
                title: Text(widget.options[index]),
                value: selectedOptions[index],
                onChanged: (newValue) {
                  setState(() {
                    selectedOptions[index] = newValue!;
                    widget.onChanged(getSelectedOptions());
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  List<String> getSelectedOptions() {
    List<String> selected = [];
    for (int i = 0; i < selectedOptions.length; i++) {
      if (selectedOptions[i]) {
        selected.add(widget.options[i]);
      }
    }
    return selected;
  }
}