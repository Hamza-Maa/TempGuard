class alertlistdata {
  String id_device;
  String id_alert;
  String indicator;
  int minValue;
  int maxValue;
  String notif_type;

  alertlistdata({
    required this.id_device,
    required this.id_alert,
    required this.indicator,
    required this.minValue,
    required this.maxValue,
    this.notif_type = '', // Initialize with an empty string or the appropriate default value
  });

  factory alertlistdata.fromJson(Map<String, dynamic> json) {
    return alertlistdata(
      id_device: json['id_device'],
      id_alert: json['id_alert'],
      indicator: json['indicator'],
      minValue: json['minValue'],
      maxValue: json['maxValue'],
      notif_type: json['notif_type'] ?? '', // Use an empty string as default if null
    );
  }

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_device': id_device,
      'id_alert': id_alert,
      'indicator': indicator,
      'minValue': minValue,
      'maxValue': maxValue,
      'notif_type': notif_type,
    };
  }
}
