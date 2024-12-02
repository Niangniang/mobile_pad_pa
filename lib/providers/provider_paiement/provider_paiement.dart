import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_evenement/model_evenement.dart';
import 'package:mobile_pad_pa/services/service_paiement/service_paiement.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';



class PaiementProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  dynamic? _newPaiement;
  dynamic? get newPaiement => _newPaiement;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }


  Future<void> addPaiement({required Map<String, dynamic> data, required String id, required BuildContext context}) async {
    setLoading(true);

    http.Response response = await ServicePaiement().addPaiement(data, id);

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("response add paiement ${response.body}");
      var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
       _newPaiement = data ;

      setLoading(false);
    } else {
      setLoading(false);
      debugPrint("Error ${jsonEncode(response.body)}");
    }
  }





}