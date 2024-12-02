import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';


class ServicePersonneDemande{

  Future<http.Response> getAllPersonneDemandes(BuildContext context, String accessToken) async {

    try {
      var url = Uri.parse("$uri/personneDemandee/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all personneDemandes");
          return response;
        case 201:
          debugPrint("Success get all personneDemandes");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all personneDemandes failed api call");
      rethrow;
    }
  }

}