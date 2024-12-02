import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'package:mobile_pad_pa/services/service_objetRDV/objet_RDV.dart';
import 'package:mobile_pad_pa/services/service_personneDemande/service_personneDemande.dart';
import 'dart:convert';
import '../../models/model_infrastructure/model_infrastructure.dart';


class PersonneDemandeProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  late bool _hasFetchedPersonneDemande = false;

  List<PersonneDemande> _listPersonneDemande = [];
  List<PersonneDemande> get listPersonneDemnade  => _listPersonneDemande;

  PersonneDemande? _personneDemande ;
  PersonneDemande? get personneDemande  => _personneDemande;

  String  _personneDemandeId= "" ;
  String  get personneDemandeId  => _personneDemandeId;




  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }

  void setSingleDemandePersonne(PersonneDemande? personneDemande) {
    _personneDemande = personneDemande;
    notifyListeners();
  }
  void setSinglePersonneDemandeById(String pressoneDemandeId) {
    _personneDemandeId = pressoneDemandeId;
    notifyListeners();
  }


  List<String> convertObjetRDVsToStringList(List<ObjetRDV> objetsRDVs) {
    return objetsRDVs.map((e) => "${e.objet}").toList();
  }


  Future<void> getAllPersonneDemande({required BuildContext context, required String accessToken}) async {
    if (!_hasFetchedPersonneDemande) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServicePersonneDemande().getAllPersonneDemandes(context, accessToken );
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listPersonneDemande= data.map((e) => PersonneDemande.fromJson(e)).toList();
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching personneDemande: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedPersonneDemande = true;  // Marquez que les données ont été chargées une fois
    }
  }


}