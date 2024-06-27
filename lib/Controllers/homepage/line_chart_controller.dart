import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../Models/homepage/LineChart_Model.dart';

class LineChartController {
  final String apiUrl; // Replace this with your private server API URL
  LineChartModel model;

  LineChartController({required this.apiUrl})
      : model = LineChartModel(
    humiditeData: [],
    tempsData: [],
    temperatureData: [],
  );

  Future<void> fetchData(String deviceId, void Function() setStateCallback) async {
    try {
      final url = '$apiUrl/$deviceId'; // Append the device ID to the URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<Map<String, dynamic>> sortedData = [];

        jsonData.forEach((value) {
          if (value != null &&
              value['humidity'] != null &&
              value['temperature'] != null &&
              value['time_stamp'] != null) {
            double humidite = double.tryParse(value['humidity'].toString()) ??
                0;
            double temperature = double.tryParse(
                value['temperature'].toString()) ?? 0;

            String temps = value['time_stamp'].toString();
            String temps_2 = temps.substring(11, 16);

            // Convert the time to DateTime
            DateTime dateTime = DateFormat("HH:mm").parse(temps_2);

            sortedData.add({
              'humidity': humidite,
              'time_stamp': dateTime, // Change to DateTime object
              'temperature': temperature,
            });
          }
        });

        // Sort the data based on the 'time_stamp' (time) value
        sortedData.sort((a, b) => a['time_stamp'].compareTo(b['time_stamp']));

        // Clear the existing data in the model
        model.humiditeData.clear();
        model.tempsData.clear();
        model.temperatureData.clear();

        // Add the sorted data to the model
        sortedData.forEach((data) {
          model.humiditeData.add(data['humidity']);
          model.tempsData.add(data['time_stamp']);
          model.temperatureData.add(data['temperature']);
        });

        setStateCallback(); // Trigger widget rebuild after fetching and updating data
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching data: $e');
    }
  }
}


