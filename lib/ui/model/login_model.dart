import 'package:challenge/model/services/base_service.dart';
import 'package:challenge/model/services/media_service.dart';

class LoginModel {
  final String? username;
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;
  final String? token;

  LoginModel(
      {this.username,
      this.password,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.image,
      this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      username: json["username"],
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      gender: json["gender"],
      image: json["image"],
      token: json["token"],
    );
  }
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  BaseService _mediaService = Service();

  Future<LoginModel> postLogin() async {
    dynamic response = await _mediaService.postResponse("auth/login", toJson());
    LoginModel login = LoginModel.fromJson(response);
    return login;
  }
}
