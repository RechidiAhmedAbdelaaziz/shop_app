class LoginModel {
  late bool status;
  late String message;
  late UserData? data;
  LoginModel({
    required this.status,
    required this.message,
    required this.data
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?UserData.fromJson(json['data']):null;
    
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? poitns;
  int? credits;
  String? token;
  // UserData(
  //     {required this.id,
  //     required this.name,
  //     required this.email,
  //     required this.phone,
  //     required this.image,
  //     required this.poitns,
  //     required this.credits,
  //     required this.token});
  UserData.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    email = json?['email'];
    image = json?['image'];
    phone = json?['phone'];
    poitns = json?['poitns'];
    credits = json?['credits'];
    token = json?['token'];
  }
}
