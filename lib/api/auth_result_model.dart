// To parse this JSON data, do
//
//     final signInResult = signInResultFromJson(jsonString);

import 'dart:convert';

SignInResult signInResultFromJson(String str) => SignInResult.fromJson(json.decode(str));

String signInResultToJson(SignInResult data) => json.encode(data.toJson());

class SignInResult {
  String success;
  dynamic errorMessage;
  String loginAccessKey;

  SignInResult({
    required this.success,
    required this.errorMessage,
    required this.loginAccessKey,
  });

  factory SignInResult.fromJson(Map<String, dynamic> json) => SignInResult(
    success: json["success"],
    errorMessage: json["errorMessage"],
    loginAccessKey: json["loginAccessKey"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "errorMessage": errorMessage,
    "loginAccessKey": loginAccessKey,
  };
}

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  int id;
  String username;
  String firstName;
  String lastName;

  Customer({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
  };
}

