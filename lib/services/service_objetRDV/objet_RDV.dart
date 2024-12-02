import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';


class ServiceObjetRDV{



  Future<http.Response> getObjetRDVById(BuildContext context, String id, String accessToken) async {

    try {
      var url = Uri.parse("$uri/objetRDV/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get objetRDV");
          return response;
        case 201:
          debugPrint("Success get objetRDV");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get objetRDV failed api call");
      rethrow;
    }
  }

  Future<http.Response> getAllObjetRDVs(BuildContext context, String accessToken) async {

    try {
      var url = Uri.parse("$uri/ObjetRDV/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all objetRDVs");
          return response;
        case 201:
          debugPrint("Success get all objetRDVs");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all objetRDVs failed api call");
      rethrow;
    }
  }

}