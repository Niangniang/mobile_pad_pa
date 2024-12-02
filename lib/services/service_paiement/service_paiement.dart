import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_pad_pa/constantes/api_base_url.dart';



class ServicePaiement{


  Future<http.Response> addPaiement(
      Map<String, dynamic> paiement, String id) async {
    try {
      var url = Uri.parse("$uri/paiements/paiement_client/id=$id");
      final response = await http.post(url,
          body: jsonEncode(paiement),
          headers: <String, String>{"Content-Type": "application/json"});
      switch (response.statusCode) {
        case 200:
          debugPrint("Success add Paiement");
          return response;
        case 201:
          debugPrint("Success add Paiement");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("add paiement failed api call");
      rethrow;
    }
  }

}