import 'package:flutter/cupertino.dart';
import 'package:mobile_pad_pa/constantes/api_base_url.dart';
import 'package:http/http.dart' as http;

class AnnouncementService{


  Future<http.Response> getAllAnnouncement(BuildContext context, String accessToken) async {

    try {
      var url = Uri.parse("$uri/announcement/all");
      final response = await http.get(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success get all announcement");
          return response;
        case 201:
          debugPrint("Success get all announcement");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("get all announcement failed api call");
      rethrow;
    }
  }

}