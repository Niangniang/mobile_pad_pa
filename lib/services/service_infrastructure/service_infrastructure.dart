import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:provider/provider.dart';

class ServiceInfrastructure {
  Future<http.Response> getInfrastructureById(
      BuildContext context, String id, String accesToken) async {
    try {
      var url = Uri.parse("$uri/infrastructure/$id");

      final response = await http.get(url, headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accesToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get infra by Id");
          return response;
        case 201:
          debugPrint("Success get infra by Id");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get infra by Id failed api call");
      rethrow;
    }
  }

  Future<http.Response> getAllInfrastructuresByType(
      BuildContext context, String id, String accesToken) async {
    try {
      var url = Uri.parse("$uri/infrastructure/type/typeInfraId/$id");

      final response = await http.get(url, headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accesToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all infras by type");
          return response;
        case 201:
          debugPrint("Success get all infras by typpe");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all infras by type failed api call");
      rethrow;
    }
  }

  Future<http.Response> getAllInfrastructures(BuildContext context) async {
    var authprovider = Provider.of<AuthProvider>(context, listen: false);
    var token = authprovider.authLogin?.access;
    try {
      var url = Uri.parse("$uri/infrastructure/all");
      final response = await http.get(url, headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all infras");
          return response;
        case 201:
          debugPrint("Success get all infras");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all infras failed api call");
      rethrow;
    }
  }
}
