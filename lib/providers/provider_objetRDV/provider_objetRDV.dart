import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'package:mobile_pad_pa/services/service_objetRDV/objet_RDV.dart';
import 'dart:convert';
import '../../models/model_infrastructure/model_infrastructure.dart';


class ObjetRDVProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  late bool _hasFetchedObjetRDV = false;

  List<ObjetRDV> _listObjetRDVs = [];
  List<ObjetRDV> get listObjetRDVs  => _listObjetRDVs;

  ObjetRDV? _objetRDV ;
  ObjetRDV? get objetRDV  => _objetRDV;

  ObjetRDV? _getedObjetRDV ;
  ObjetRDV? get getedObjetRDV  => _getedObjetRDV;

  String  _objetRDVId="" ;
  String  get objetRDVId  => _objetRDVId;




  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }

  void setSingleObjetRDV(TypeEvenement? typeEvenement) {
    _objetRDV = objetRDV;
    notifyListeners();
  }
  void setSingleObjetRDVById(String objetRDVId) {
    _objetRDVId = objetRDVId;
    notifyListeners();
  }


  List<String> convertObjetRDVsToStringList(List<ObjetRDV> objetsRDVs) {
    return objetsRDVs.map((e) => "${e.objet}").toList();
  }



  Future<void> getObjetRDVById({required BuildContext context, required String id, required String accessToken}) async {
    if (!_hasFetchedObjetRDV) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServiceObjetRDV().getObjetRDVById(context, id, accessToken);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
          debugPrint('=================> data $data');

          _getedObjetRDV = ObjetRDV.fromJson(data);
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching creneau: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedObjetRDV = true;  // Marquez que les données ont été chargées une fois
    }
  }


  Future<void> getAllObjetRDVs({required BuildContext context, required String accessToken}) async {
    if (!_hasFetchedObjetRDV) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServiceObjetRDV().getAllObjetRDVs(context, accessToken );
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listObjetRDVs = data.map((e) => ObjetRDV.fromJson(e)).toList();
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching typeEvenements: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedObjetRDV = true;  // Marquez que les données ont été chargées une fois
    }
  }


}