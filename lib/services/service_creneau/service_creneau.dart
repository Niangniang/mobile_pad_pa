import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';


class ServiceCreneau{




  Future<http.Response> addCreneau(Map<String, dynamic> creneau, String accessToken) async {
    try {
      var url = Uri.parse("$uri/evenement/Creneau/add");
      final response = await http.post(
        url,
        body: jsonEncode(creneau),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint("Success add Creneau");
          return response;
        default:
          debugPrint("Failed to add Creneau: ${response.statusCode}");
          return response;
      }
    } on Exception catch (e) {
      debugPrint("add creneau failed api call: $e");
      rethrow;
    }
  }

 /* Future<http.Response> getAllCreneauByPersonneDemande(BuildContext context, String accessToken) async {

    try {
      var url = Uri.parse("$uri/crenau/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all creneaux persona");
          return response;
        case 201:
          debugPrint("Success get all creneaux persona");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all creneaux persona failed api call");
      rethrow;
    }
  }
*/
  Future<http.Response> getCreneauById(BuildContext context, String id, String accessToken) async {

    try {
      var url = Uri.parse("$uri/creneau/$id");
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


  Future<http.Response> getAllCreneauxByPersonneDemandee(BuildContext context, String id ,String date, String accessToken) async {
    try {
      var url = Uri.parse("$uri/creneau/personnedemande/requestedDate?id_personneDemande=$id&requestedDate=$date");
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

}