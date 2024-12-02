import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';



class ServiceNotification{


  Future<http.Response> getAllNotifications(BuildContext context, String accessToken) async {

    try {
      var url = Uri.parse("$uri/announcement/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all notifications");
          return response;
        case 201:
          debugPrint("Success get all notifications");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all notifications failed api call");
      rethrow;
    }
  }


  Future<http.Response> getAllNotificationsByUser(BuildContext context, String id, String accessToken) async {

    try {
      var url = Uri.parse("$uri/evenement/rappel/userId/$id");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all notifications by User");
          return response;
        case 201:
          debugPrint("Success get all notifications by User");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all notifications by user failed api call");
      rethrow;
    }
  }





}