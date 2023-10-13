import 'dart:convert';

import 'package:fin_app/api/auth_result_model.dart';

class AuthUser{
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String jwtToken;

  AuthUser(
      this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.jwtToken
      );
  static AuthUser fromCustomerJwt(Customer customer, String jwtToken){
    return AuthUser(
        customer.id,
        customer.username,
        customer.firstName,
        customer.lastName,
        jwtToken);
  }
}
class SignInModel{
  final String username;
  final String password;

  SignInModel(this.username, this.password);
}

class SignUpModel extends SignInModel{
  final String firstName;
  final String lastName;
  final String idNumber;

  SignUpModel(this.firstName, this.lastName, this.idNumber, username, password) : super(username,password);

  String toJsonStr() => json.encode({
    "username": username,
    "password": password,
    "firstName": firstName,
    "lastName": lastName,
    "idNumber": idNumber
  });

}