import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_creneau/model_creneau.dart';
import 'dart:convert';

import 'package:mobile_pad_pa/services/service_creneau/service_creneauEvent.dart';



class CreneauEventProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;
  bool _hasFetchedCreneau = false;


  CreneauEvent? _getedCreneau;
  CreneauEvent? get getedCreneau => _getedCreneau;

  CreneauEvent?  _creneauEvent;
  CreneauEvent? get creneauEvent => _creneauEvent;


  String?  _dateDebut;
  String? get dateDebut => _dateDebut;

  String?  _dateFIn;
  String? get dateFIn => _dateFIn;


  List<CreneauEvent> _listCreneauxDateAndByInfra = [];
  List<CreneauEvent> get listCreneauxDateAndByInfra => _listCreneauxDateAndByInfra;


  // Ajoutez cette méthode pour vider la liste des infrastructures
  void clearCreneaux() {
    listCreneauxDateAndByInfra.clear();
    notifyListeners();
  }


  void setDateDebut(String dateDebut) {
    _dateDebut = dateDebut;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


  void setDateFIn(String dateFin) {
    _dateFIn = dateFin;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setCreneauEvent(CreneauEvent creneauEvent) {
    _creneauEvent = creneauEvent;
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

  Future<void> addCreneauEvent({required Map<String, dynamic> creneauEvent, required String accessToken, required BuildContext context}) async {
    setLoading(true);

    try {
      http.Response response = await ServiceCreneauEvent().addCreneauEvent(
        creneauEvent,
        accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("response add evenement ${response.body}");

        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        debugPrint('=================> data $data');

        _getedCreneau = CreneauEvent.fromJson(data);

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

  Future<void> getAllCreneauEventByDateAndInfra({required BuildContext context,required String id, required String date,  required String accessToken}) async {

    setLoading(true);
    try {
      http.Response response = await ServiceCreneauEvent().getAllCreneauEventByDateAndTypeInfra(
        context, id, date, accessToken

      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listCreneauxDateAndByInfra = data.map((e) => CreneauEvent.fromJson(e)).toList();
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
    } finally {
      setLoading(false);
    }


  }




  Future<void> getCreneauById({required BuildContext context, required String id, required String accessToken}) async {
    if (!_hasFetchedCreneau) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServiceCreneauEvent().getCreneauEventById(context, id, accessToken);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
          debugPrint('=================> data $data');

          _getedCreneau = CreneauEvent.fromJson(data);
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