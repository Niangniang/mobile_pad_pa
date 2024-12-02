import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_pad_pa/services/service_typeEvenement/service_typeEvenement.dart';
import '../../models/model_infrastructure/model_infrastructure.dart';


class TypeEvenementProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  bool _hasFetchedTypeEvenement = false;

  List<TypeEvenement> _listTypeEvenements = [];
  List<TypeEvenement> get listTypeEvenements => _listTypeEvenements;

  TypeEvenement? _typeEvenement;
  TypeEvenement? get typeEvenement => _typeEvenement;


  TypeEvenement? _getedTypeEvenement;
  TypeEvenement? get getedTypeEvenement => _getedTypeEvenement;

  String _typeEvenementId = "";
  String get typeEvenementId => _typeEvenementId;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setSingleTypeEvent(TypeEvenement? typeEvenement) {
    _typeEvenement = typeEvenement;
    notifyListeners();
  }

  void setSingleTypeEventById(String typeEventId) {
    _typeEvenementId = typeEventId;
    notifyListeners();
  }

  List<String> convertTypeEvenementsToStringList(List<TypeEvenement> evenements) {
    return evenements.map((e) => "${e.libelle}").toList();
  }



  Future<void> getTypeEvenementById({required BuildContext context, required String accessToken, required String id}) async {
    setLoading(true);

    try {
      http.Response response = await ServiceTypeEvenement().getTypeEvenementById(
          context,
          accessToken,
          id
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        debugPrint('=================> data $data');

        _getedTypeEvenement = TypeEvenement.fromJson(data);

        debugPrint('=================> getedEvent $_getedTypeEvenement');
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching type event: $e");
    } finally {
      setLoading(false);
    }
  }


  Future<void> getAllTypeEvenements({required BuildContext context}) async {
      setLoading(true);
      try {
        http.Response response = await ServiceTypeEvenement().getAllTypeEvenements(context);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listTypeEvenements = data.map((e) => TypeEvenement.fromJson(e)).toList();
          _hasFetchedTypeEvenement = true;
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching typeEvenements: $e");
      } finally {
        setLoading(false);
      }

  }
}
