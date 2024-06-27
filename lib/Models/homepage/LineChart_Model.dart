class LineChartModel {
  List<double> humiditeData;
  List<DateTime> tempsData; // Change the type to DateTime
  List<double> temperatureData;

  LineChartModel({
    required this.humiditeData,
    required this.tempsData,
    required this.temperatureData,
  });
}
