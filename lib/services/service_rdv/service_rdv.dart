import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_pad_pa/constantes/api_base_url.dart';



class ServiceRDV{


  Future<http.Response> addRDV(Map<String, dynamic> rdv, String accessToken) async {
    try {
      var url = Uri.parse("$uri/rdv/add");
      final response = await http.post(
        url,
        body: jsonEncode(rdv),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint("Success add RDV");
          return response;
        default:
          debugPrint("Failed to add RDV: ${response.statusCode}");
          return response;
      }
    } on Exception catch (e) {
      debugPrint("add RDV failed api call: $e");
      rethrow;
    }
  }


  Future<http.Response> annulerRDV(String id, String accessToken) async {
    try {
      var url = Uri.parse("$uri/rdv/AnnulerRdvByClientId/$id");
      final response = await http.patch(
        url,
       // body: jsonEncode(rdv),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint("Success to cancel apointment");
          return response;
        default:
          debugPrint("Failed to cancel apointment: ${response.statusCode}");
          return response;
      }
    } on Exception catch (e) {
      debugPrint(" Failed to cancel apointment: $e");
      rethrow;
    }
  }




  Future<http.Response> getAllRDVs(BuildContext context, String accessToken) async {

    try {
      var url = Uri.parse("$uri/rdv/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all RDVs");
          return response;
        case 201:
          debugPrint("Success get all RDVs");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all RDVs failed api call");
      rethrow;
    }
  }


  Future<http.Response> getAllRDVsByUser(BuildContext context, String accessToken, String id) async {

    try {
      var url = Uri.parse("$uri/rdv/listAll/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all user RDVs");
          return response;
        case 201:
          debugPrint("Success get all user RDVs");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all RDVs by user failed api call");
      rethrow;
    }
  }


  Future<http.Response> getRDVById(BuildContext context, String accessToken, String id) async {

    try {
      var url = Uri.parse("$uri/rdv/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get RDV");
          return response;
        case 201:
          debugPrint("Success get  RDV");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get RDV failed api call");
      rethrow;
    }
  }





}