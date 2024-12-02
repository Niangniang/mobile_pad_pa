import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'package:mobile_pad_pa/services/service_creneau/service_creneau.dart';
import 'dart:convert';



class CreneauPersonneDemandeProvider extends ChangeNotifier {


  bool _loading = false;
  bool get loading => _loading;

  List<Creneau> _lisCreneauPersonneDemandee = [];
  List<Creneau> get lisCreneauPersonneDemandee  => _lisCreneauPersonneDemandee;

  String? _creneauId;
  String? get creneauId => _creneauId;

  Creneau? _getedCreneau;
  Creneau? get getedCreneau => _getedCreneau;


  Creneau? _getedCreneauPersonneDemandee;
  Creneau? get getedCreneauPersonneDemandee => _getedCreneauPersonneDemandee;


  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }


  void setGetedCreneau(Creneau creneau) {
    _getedCreneau = creneau;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


  void setCr(String creneauId) {
    _creneauId = creneauId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getAllCreneauxByPersonneDemandee({required BuildContext context, required String id, required String date, required String accessToken}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceCreneau().getAllCreneauxByPersonneDemandee(
          context,
          id,
          date,
          accessToken
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _lisCreneauPersonneDemandee = data.map((e) => Creneau.fromJson(e)).toList();
        notifyListeners();
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
    } finally {
      setLoading(false);
    }
  }
}