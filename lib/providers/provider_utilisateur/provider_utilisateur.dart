import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/services/service_utilisateur/service_utilisateur.dart';
import 'package:provider/provider.dart';

class UtilisateurProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  // Fonction pour gérer l'état de chargement
  setLoading(bool value) {
    if (_loading != value) {
      _loading = value;
      notifyListeners();
    }
  }

  // Fonction pour mettre à jour la photo de l'utilisateur
  Future<void> updateUserPicture({
    required BuildContext context,
    required String accessToken,
    required String id,
    required File imageFile,
  }) async {
    setLoading(true); // Active l'indicateur de chargement
    try {

      http.Response response = await ServiceUtilisateur().uploadUserPicture(
          context, accessToken, id, imageFile
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));


        String newPhotoUrl = data['attachement'];

        Provider.of<AuthProvider>(context, listen: false).updateAttachement(newPhotoUrl);
        debugPrint("Photo updated successfully with new URL: $newPhotoUrl");
      } else {
        debugPrint("Error with status code: ${response.statusCode}");
        debugPrint("Error body: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error updating user picture: $e");
    } finally {
      setLoading(false);
    }
  }
}
