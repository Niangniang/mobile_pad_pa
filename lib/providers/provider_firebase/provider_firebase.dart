import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/services/service_firebase/service_firebase.dart';



class FirebaseProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  String _tokenFirebase = '';
  String get tokenFirebase => _tokenFirebase;

  void setTokenFirebase(String token) {

    _tokenFirebase = token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

  }



  setLoading(bool value) {
    if (_loading != value) {
      _loading = value;
      notifyListeners();
    }
  }

  Future<void> saveTokenFirebase({required Map<String, dynamic> data, required String accessToken, required BuildContext context}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceFirebase().saveTokensFirebase(data, accessToken,);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("response save token firebase ${response.body}");
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("add evenement failed api call: $e");
    } finally {
      setLoading(false);
    }
  }




}