import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_pad_pa/constantes/api_base_url.dart';



class ServiceEvenement{


  Future<http.Response> addEvenement(Map<String, dynamic> evenement, String accessToken) async {
    try {
      var url = Uri.parse("$uri/evenement/add");
      final response = await http.post(
        url,
        body: jsonEncode(evenement),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint("Success add Evenement");
          return response;
        default:
          debugPrint("Failed to add Evenement: ${response.statusCode}");
          return response;
      }
    } on Exception catch (e) {
      debugPrint("add evenement failed api call: $e");
      rethrow;
    }
  }



  Future<http.Response> getAllEvenementsByInfra(BuildContext context, String id,  String accessToken) async {
    try {
      var url = Uri.parse("$uri/evenement/evenementByInfraId/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all events");
          return response;
        case 201:
          debugPrint("Success get all events");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all events failed api call");
      rethrow;
    }
  }


  Future<http.Response> getAllEvenements(BuildContext context, String accessToken) async {
    try {
      var url = Uri.parse("$uri/evenement/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all events");
          return response;
        case 201:
          debugPrint("Success get all events");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all events failed api call");
      rethrow;
    }
  }


  Future<http.Response> getAllEvenementsByUser(BuildContext context, String accessToken, String id) async {
    try {
      var url = Uri.parse("$uri/evenement/UserId/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all user events");
          return response;
        case 201:
          debugPrint("Success get all user events");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all events by user failed api call");
      rethrow;
    }
  }


  Future<http.Response> getAllEvenementsByTypeEvenemnet(BuildContext context, String accessToken, String id) async {

    try {
      var url = Uri.parse("$uri/evenement/evenementByTypeEvenementId/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all user events");
          return response;
        case 201:
          debugPrint("Success get all user events");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all events by user failed api call");
      rethrow;
    }
  }


  Future<http.Response> getEvenementById(BuildContext context, String accessToken, String id) async {

    try {
      var url = Uri.parse("$uri/evenement/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get event");
          return response;
        case 201:
          debugPrint("Success get event");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get event failed api call");
      rethrow;
    }
  }
}