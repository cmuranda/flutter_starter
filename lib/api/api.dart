
import 'dart:convert';
import 'dart:io';

import 'package:fin_app/api/auth_result_model.dart';
import 'package:fin_app/products/product_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

import '../auth/auth_model.dart';

// const String apiUrl = "192.168.56.1:8080";
const String apiUrl = "138.68.89.122:8080";
const String apiVersion = '/v1';

String getBasicAuthHeaders(String namePassword){
  return 'Basic ${base64.encode(utf8.encode(namePassword))}';
}

String getBearerAuthHeader(String token){
  return 'Bearer $token';
}

class Api{

  late Store<ApplicationState> state;

  Future<List<Product>> getProducts() async {
    var url = Uri.http(apiUrl, '$apiVersion/products');
    var results = await http.get(url);
    if(results.statusCode != 200){
      throw ApiException(results.body, results.statusCode);
    }
    return productsFromJson(results.body);
  }

  Future<SignInResult> signInUser(SignInModel parameters) async{
    String basicAuth = getBasicAuthHeaders('${parameters.username}:${parameters.password}');
    var authHeader = {
      HttpHeaders.authorizationHeader: basicAuth
    };
    var url = Uri.http(apiUrl, '$apiVersion/token');
    var results = await http.post(url, headers: authHeader);
    if (results.statusCode != 200){
      throw ApiException(results.body, results.statusCode);
    }
    return signInResultFromJson(results.body);
  }

  Future<Customer> getUserByEmail(String userName, String jwtToken) async{
    var url = Uri.http(apiUrl, "$apiVersion/customer", {"emailAddress": userName});
    var authHeaders = {
      HttpHeaders.authorizationHeader: getBearerAuthHeader(jwtToken)
    };
    var results = await http.get(url, headers: authHeaders);
    print(results.body);
    print(results.statusCode);
    if (results.statusCode != 200){

      throw ApiException(results.body, results.statusCode);
    }
    return customerFromJson(results.body);
  }

  Future<String> getAdminToken() async{
    var adminAuthModel = SignInModel("admin@entelect.co.za", "password");
    var adminCredentials = await signInUser(adminAuthModel);
    return adminCredentials.loginAccessKey;
  }

  Future<Customer> signUpUser(SignUpModel parameters) async{
    String adminJwt = await getAdminToken();
    var authHeader = {
      HttpHeaders.authorizationHeader: getBearerAuthHeader(adminJwt),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    var url = Uri.http(apiUrl, "$apiVersion/customer");
    var results = await http.post(url, headers: authHeader, body: parameters.toJsonStr());

    if (results.statusCode != 200){
      throw ApiException(results.body, results.statusCode);
    }
    return customerFromJson(results.body);
  }

  takeUpProducts(String jwt, String body) async {
    var authHeader = {
      HttpHeaders.authorizationHeader: getBearerAuthHeader(jwt),
      HttpHeaders.contentTypeHeader: "application/json"
    };
    var url = Uri.http(apiUrl, "$apiVersion/product/take-up");
    var results = await http.post(url, headers: authHeader, body: body);
    print(results.statusCode);
    print(results.body);

  }
}

class ApiException {
  final String message;
  final int statusCode;

  ApiException(
      this.message,
      this.statusCode
  );
}