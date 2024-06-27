import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempguard_flutter_app/Controllers/alert/setalarme_controller.dart';
import 'package:tempguard_flutter_app/Models/alert/AlertList_model.dart';

import 'AlertsList_view.dart';

class SetNewAlert extends StatefulWidget {
  @override
  _SetNewAlertState createState() => _SetNewAlertState();
}

class _SetNewAlertState extends State<SetNewAlert> {
  int minValue = 0;
  int maxValue = 25;



  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();
  late String selectedDevice = '';
  late String selectedindicator = '';
  late String selectedAlertType = '';


  @override
  void initState() {
    super.initState();
    selectedDevice = 'DEVICE 1';
    selectedindicator = 'TEMPERATURE';
    selectedAlertType = '';
    minController.text = minValue.toString();
    maxController.text = maxValue.toString();
  }

  void updateSliderValues() {
    if (mounted) {

      setState(() {
      minValue = int.tryParse(minController.text) ?? 0;
      maxValue = int.tryParse(maxController.text) ?? 25;

      if (selectedindicator == 'TEMPERATURE') {
        if (minValue < -20) {
          minValue = -20;
          minController.text = minValue.toString();
        }
        if (maxValue > 50) {
          maxValue = 50;
          maxController.text = maxValue.toString();
        }
      } else {
        if (minValue < 0) {
          minValue = 0;
          minController.text = minValue.toString();
        }
        if (maxValue > 100) {
          maxValue = 100;
          maxController.text = maxValue.toString();
        }
      }

      if (minValue > maxValue) {
        minValue = maxValue;
        minController.text = minValue.toString();
        showRangeExceededDialog('Min value cannot be greater than Max value.');
      }

      // Ensure that the values are within the allowable range
      if (minValue < (selectedindicator == 'TEMPERATURE' ? -20 : 0)) {
        minValue = (selectedindicator == 'TEMPERATURE' ? -20 : 0);
        minController.text = minValue.toString();
      }

      if (maxValue > (selectedindicator == 'TEMPERATURE' ? 50 : 100)) {
        maxValue = (selectedindicator == 'TEMPERATURE' ? 50 : 100);
        maxController.text = maxValue.toString();
      }
    });}
  }

  void showRangeExceededDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Range Exceeded'),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF26326A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void confirmAlert() {
    alertlistdata alertData = new alertlistdata(
        id_device: selectedDevice,
        id_alert: "id_alert",
        indicator: selectedindicator,
        minValue: minValue,
        maxValue: maxValue,
        notif_type: selectedAlertType);

    final controller = AlertController(
        "http://192.168.100.189:5000/tempguard/device/alerts/iHUAsursTMccEbi3gYQ6wQ");
    controller.saveAlert(alertData);

    // Navigate to AlertsList screen
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => AlertsList()))
        .then((_) {
      // Trigger the function after navigating to the page
      (context as Element)
          .markNeedsBuild(); // Forces a rebuild to call initState
      // or you can directly call the function if you have a reference to the state
      // DestinationPage().onPageLoad();
    });
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
                  color: const Color(0xFF26326A),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AlertsList()),
                              );
                            },
                            child: Transform.rotate(
                              angle: 90 * 3.1415926535 / 180,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          ),
                          const Text(
                            'Set New Alert',
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
              const SizedBox(height: 30),
              MyDropdown(
                dropdownOptions: ['DEVICE 1', 'DEVICE 2', 'DEVICE 3'],
                titleText: 'DEVICE',
                onChanged: (value) {
    if (mounted) {

    setState(() {
                    selectedDevice = value!;
                  });}
                },
              ),
              const SizedBox(height: 20),
              MyDropdown(
                dropdownOptions: ['TEMPERATURE', 'HUMIDITY', 'BATTERY'],
                titleText: 'INDICATOR',
                onChanged: (value) {
    if (mounted) {

    setState(() {
                    selectedindicator = value!;
                    // Reset the minValue and maxValue based on the selectedindicator
                    if (selectedindicator == 'TEMPERATURE') {
                      minValue = -20;
                      maxValue = 50;
                    } else {
                      minValue = 0;
                      maxValue = 100;
                    }
                    // Update the text controllers for the inputs
                    minController.text = minValue.toString();
                    maxController.text = maxValue.toString();
                  });}
                },
              ),

              Padding(
                padding: const EdgeInsets.only(right: 260, top: 30),
                child: const Text(
                  'CONDITION',
                  style: TextStyle(
                    color: Color(0xFF26326A),
                    fontSize: 16.0,
                  ),
                ),
              ),

              RangeSlider(
                min: (selectedindicator == 'TEMPERATURE') ? -20 : 0,
                max: (selectedindicator == 'TEMPERATURE') ? 50 : 100,
                divisions: 60,
                values: RangeValues(minValue.toDouble(), maxValue.toDouble()),
                onChanged: (RangeValues values) {
    if (mounted) {

    setState(() {
                    minValue = values.start.toInt();
                    maxValue = values.end.toInt();
                    minController.text = minValue.toString();
                    maxController.text = maxValue.toString();
                  });}
                },
              ),



              Row(
                children: [
                  SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Min:',
                      style: TextStyle(
                        color: Color(0xFF696969),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: 50, left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFF7F9FD),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          controller: minController,
                          onChanged: (value) {
                            updateSliderValues();
                          },
                          keyboardType: TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d*\.?\d*'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Max:',
                      style: TextStyle(
                        color: Color(0xFF696969),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 55),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xFFF7F9FD),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          controller: maxController,
                          onChanged: (value) {
                            updateSliderValues();
                          },
                          keyboardType: TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d*\.?\d*'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),


              MyCheckboxGroup(
                options: ['SMS', 'Mail'],
                titleText: 'ALERT TYPE',
                onChanged: (value) {
    if (mounted) {

    setState(() {
                    if (value.contains('SMS') && value.contains('Mail')) {
                      selectedAlertType = 'SMS Mail';
                    } else if (value.contains('SMS')) {
                      selectedAlertType = 'sms';
                    } else if (value.contains('Mail')) {
                      selectedAlertType = 'mail';
                    } else {
                      selectedAlertType = ''; // No option selected
                    }
                  });}
                },
              ),


              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: confirmAlert,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
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
              const SizedBox(height: 10),
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
                  if (mounted) {

                    setState(() {
                    selectedOptions[index] = newValue!;
                    widget.onChanged(getSelectedOptions());
                  });}
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

