class SharedeviceData {
  final String email;
  final String access_write;
  final String id_user;
  final String id_device;





  SharedeviceData({
    required this.email,
    required this.access_write,
    required this.id_user,
    required this.id_device,



  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'accesswrite': access_write,
      'id_user': id_user,
      'id_device': id_device,


    };
  }
}