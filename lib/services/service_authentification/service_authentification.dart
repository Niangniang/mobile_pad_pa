import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_pad_pa/constantes/api_base_url.dart';


class ServiceAuthentification{


  Future<http.Response> registerUser(
      Map<String, dynamic> user) async {
    try {
      var url = Uri.parse("$authuri/user/citoyen/register");
      final response = await http.post(url,
          body: jsonEncode(user),
          headers: <String, String>{"Content-Type": "application/json"});
      switch (response.statusCode) {
        case 200:
          debugPrint("Success register");
          return response;
        case 201:
          debugPrint("Success register");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("registerUser failed api call");
      rethrow;
    }
  }



  Future<http.Response> logInUser(
      {required String username, required password}) async {
    try {
      var data = {"username": username, "password": password};
      debugPrint("data to send ==> ${jsonEncode(data)}");

      var url = Uri.parse("$authuri/api/user/token/");
      final response = await http.post(url,
          body: jsonEncode(data),
          headers: <String, String>{"Content-Type": "application/json"});
      switch (response.statusCode) {
        case 200:
          debugPrint("Success logIn");
          return response;
        case 201:
          debugPrint("Success logIn");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("logInUser failed api call");
      rethrow;
    }
  }

}
