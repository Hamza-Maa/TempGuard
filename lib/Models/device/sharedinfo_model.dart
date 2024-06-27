class sharedinfodata {
  String id_user;
  String username;
  String email_adress;



  sharedinfodata({
    required this.id_user,
    required this.username,
    required this.email_adress,

  });

  factory sharedinfodata.fromJson(Map<String, dynamic> json) {
    return sharedinfodata(
      id_user: json['id_user'],
      username: json['username'],
      email_adress: json['email_adress'],
    );
  }

// Convert the object to JSON
}
