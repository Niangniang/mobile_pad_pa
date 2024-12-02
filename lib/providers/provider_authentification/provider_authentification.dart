import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/composants/HttpHandleApi/http_handle_api.dart';
import 'dart:convert';
import 'package:mobile_pad_pa/models/model_login/model_login.dart';
import '../../services/service_authentification/service_authentification.dart';

class AuthProvider extends ChangeNotifier {
  AuthLogin? _authLogin;
  AuthLogin? get authLogin => _authLogin;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;


  // Supposons que authLogin est un objet User qui contient 'attachement'

  // Méthode pour mettre à jour l'attachement
  void updateAttachement(String newAttachement) {
    authLogin?.user.attachement = newAttachement;
    notifyListeners(); // Notifie les widgets écoutant ce provider
  }


  Future<void> registerUser(
      {required Map<String, dynamic> user,
      required BuildContext context}) async {
    setLoading(true);
    http.Response response = await ServiceAuthentification().registerUser(user);

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("response register User ${response.body}");
      setLoading(false);
      context.goNamed("signIn");
    } else {
      setLoading(false);
      debugPrint("Error ${jsonEncode(response.body)}");
    }
  }

  Future<void> loginUser(
      {required String username,
      required String password,
      required BuildContext context}) async {
    http.Response response = await ServiceAuthentification()
        .logInUser(username: username, password: password);

    if (response.statusCode == 200 || response.statusCode == 201) {

      debugPrint('les donnees ===============> ${response.body}');
      debugPrint("Success login ${jsonEncode(response.body)}");
      _authLogin = AuthLogin.fromJson(jsonDecode(response.body));
      notifyListeners();

      httpApiHandling(
          response: response,
          context: context,
          onSuccess: () => customToast(
              context,
              "Authentification avec succés",
              const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: GFColors.SUCCESS,
              ),
              GFToastPosition.BOTTOM));
      debugPrint("redirection login vers accueil");

      if (_authLogin?.user.profil?.intitule == 'citoyen'){
        context.goNamed("accueil");
      }
      else{
        debugPrint('Traitement impossible');
      }


    } else {
      // Suppose that the response is a JSON containing a "detail" field
      final responseData = json.decode(response.body);
      final errorMessage = responseData['detail'] ?? 'Unknown error occurred';
      showSnackBar(context, errorMessage, Colors.red.shade100);
      debugPrint("Error: $errorMessage");
    }
  }
}
