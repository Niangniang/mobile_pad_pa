import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/constantes/api_base_url.dart';


class ServiceUtilisateur{
  Future<http.Response> uploadUserPicture(BuildContext context, String accessToken, String id, File imageFile) async {
    try {
      // Créer une requête multipart de type PATCH
      var request = http.MultipartRequest('PATCH', Uri.parse("$uri/users/$id/"));

      // Ajouter les en-têtes nécessaires
      request.headers['Authorization'] = 'Bearer $accessToken';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Ajouter le fichier image à la requête
      request.files.add(
        await http.MultipartFile.fromPath(
          'attachement', // Nom du champ attendu par le serveur
          imageFile.path,
        ),
      );

      // Envoyer la requête
      var streamedResponse = await request.send();

      // Convertir la réponse streamée en `http.Response`
      var response = await http.Response.fromStream(streamedResponse);

      // Retourner la réponse
      return response;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      rethrow;
    }
  }

/*  Future<http.Response> updateUserPicture(BuildContext context, String id, String accessToken) async {

    try {
      var url = Uri.parse("$uri/users/$id/");
      final response = await http.patch(url, headers: <String, String>
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
      switch (response.statusCode) {
        case 200:
          debugPrint("Success udate user's picture");
          return response;
        case 201:
          debugPrint("Success  udate user's picture");
          return response;
        default:
          return response;
      }
    } on Exception catch (_) {
      debugPrint("udate user's picture error");
      rethrow;
    }
  }*/


}