import 'package:flutter/material.dart';

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
                setState(() {
                  selectedOption = newValue!;
                });
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
