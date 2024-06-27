
class TemperatureHumidity {
  final String id_device;
  final int temperature;
  final int humidity;
  final int battery;
  //final String status;

  TemperatureHumidity({
    required this.id_device,
    required this.temperature,
    required this.humidity,
    required this.battery,
    //required this.status,
    //required this.id,


  });

  factory TemperatureHumidity.fromJson(Map<String, dynamic> json) {
    return TemperatureHumidity(
      id_device: json['id_device'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      battery: json['battery'],
      //status: json['status'],
      //id: json['id'],


    );
  }
}
