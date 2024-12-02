import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'package:mobile_pad_pa/services/service_creneau/service_creneau.dart';
import 'dart:convert';



class CreneauProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  bool _hasFetchedCreneau = false;


  Creneau? _getedCreneau;
  Creneau? get getedCreneau => _getedCreneau;


  List<Creneau> _listCreneauxDateAndByInfra = [];
  List<Creneau> get listCreneauxDateAndByInfra => _listCreneauxDateAndByInfra;



  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }

  Future<void> addCreneau({required Map<String, dynamic> creneau, required String accessToken, required BuildContext context}) async {
    setLoading(true);

    try {
      http.Response response = await ServiceCreneau().addCreneau(
        creneau,
         accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("response add evenement ${response.body}");

        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        debugPrint('=================> data $data');

        _getedCreneau = Creneau.fromJson(data);

       // context.goNamed("accueil");
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("add evenement failed api call: $e");
    } finally {
      setLoading(false);
    }
  }


  Future<void> getCreneauById({required BuildContext context, required String id, required String accessToken}) async {
    if (!_hasFetchedCreneau) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServiceCreneau().getCreneauById(context, id, accessToken);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
          debugPrint('=================> data $data');

          _getedCreneau = Creneau.fromJson(data);
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching creneau: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedCreneau = true;  // Marquez que les données ont été chargées une fois
    }
  }


}