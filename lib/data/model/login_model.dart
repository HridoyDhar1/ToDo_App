import 'package:todo/data/model/user_model.dart';

class LoginModel {
  String? status;
  List<UserModel>? data;
  String? token;

  LoginModel({this.status, this.data, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];

    if (json['data'] is List) {
      // Handle case where data is a list of UserModel objects
      data = (json['data'] as List).map((v) => UserModel.fromJson(v)).toList();
    } else if (json['data'] is Map<String, dynamic>) {
      // Handle case where data is a single UserModel object
      data = [UserModel.fromJson(json['data'])];
    } else {
      data = []; // Default to an empty list if data is null or unexpected
    }
  }
}
