  class AlertModel {
  final String id_device;
  final String indicator;
  final int minValue;
  final int maxValue;
  final bool notif_type;

  AlertModel({
    required this.id_device,
    required this.indicator,
    required this.minValue,
    required this.maxValue,
    required this.notif_type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_device': id_device,
      'kpi': indicator,
      'minValue': minValue,
      'maxValue': maxValue,
      'alertType': notif_type,
    };
  }
}
