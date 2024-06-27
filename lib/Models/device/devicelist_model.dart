class devicelistdata {
   String id_device;
   int temperature;
   int humidity;
   int battery;
   String status_device;
   bool isSelected; // Add this property


   devicelistdata({
    required this.temperature,
    required this.id_device,
    required this.humidity,
    required this.battery,
    required this.status_device,
     this.isSelected = false, // Initialize it as false

   });

  factory devicelistdata.fromJson(Map<String, dynamic> json) {
    return devicelistdata(
      temperature: json['temperature'],
      id_device: json['id_device'],
      humidity: json['humidity'],
      battery: json['battery'],
      status_device: json['status_device'],
    );
  }

  // Convert the object to JSON
}
