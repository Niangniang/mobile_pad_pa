import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:provider/provider.dart';


class ServiceTypeEvenement{



  Future<http.Response> getAllTypeEvenements(BuildContext context) async {

    var authprovider = Provider.of<AuthProvider>(context, listen: false);
    var token = authprovider.authLogin?.access;
    try {
      var url = Uri.parse("$uri/typeEvenement/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all typeEvenements");
          return response;
        case 201:
          debugPrint("Success get all typeEvenements");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all typeEvenements failed api call");
      rethrow;
    }
  }



  Future<http.Response> getTypeEvenementById(BuildContext context, String accessToken, String id) async {

    try {
      var url = Uri.parse("$uri/typeEvenement/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get type event");
          return response;
        case 201:
          debugPrint("Success get type event");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get type event failed api call");
      rethrow;
    }
  }






}