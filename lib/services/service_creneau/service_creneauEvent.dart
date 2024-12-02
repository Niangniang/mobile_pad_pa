import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';


class ServiceCreneauEvent{




  Future<http.Response> addCreneauEvent(Map<String, dynamic> creneauEvent, String accessToken) async {
    try {
      var url = Uri.parse("$uri/evenement/Creneau/add");
      final response = await http.post(
        url,
        body: jsonEncode(creneauEvent),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint("Success add Creneau Event");
          return response;
        default:
          debugPrint("Failed to add Creneau Event: ${response.statusCode}");
          return response;
      }
    } on Exception catch (e) {
      debugPrint("add creneau Event failed api call: $e");
      rethrow;
    }
  }



  Future<http.Response> getAllCreneauEventByDateAndTypeInfra(BuildContext context, String id, String date, String accessToken, ) async {

    try {
      var url = Uri.parse("$uri/evenement/Creneau/indisponibles/$id?date=$date");
      debugPrint("URL Ver: ${url.toString()}");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",

      },);

      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all creneaux Event by Infra");
          return response;
        case 201:
          debugPrint("Success get all creneaux Event by Infra");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all creneaux Event by Infra failed api call");
      rethrow;
    }
  }



  Future<http.Response> getCreneauEventById(BuildContext context, String id, String accessToken) async {

    try {
      var url = Uri.parse("$uri/evenement/Creneau/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get creneau");
          return response;
        case 201:
          debugPrint("Success get creneau");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get creneau failed api call");
      rethrow;
    }
  }

}