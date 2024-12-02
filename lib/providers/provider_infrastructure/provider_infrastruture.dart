import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'dart:convert';
import 'package:mobile_pad_pa/services/service_infrastructure/service_infrastructure.dart';


class InfrastructureProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  List<Infrastructure> _listInfras = [];
  List<Infrastructure> get listInfras  => _listInfras;

  List<Infrastructure> _listInfrasType = [];
  List<Infrastructure> get listInfrasType  => _listInfrasType;

  Infrastructure? _infra ;
  Infrastructure? get infra  => _infra;


  bool _hasFetchedInfras = false;


  String _infraId = '';
  String get infraId => _infraId;


  String _typeinfraId = '';
  String get typeinfraId => _typeinfraId;


  void setSingleInfraById(String InfraId) {
    _infraId = InfraId;
    notifyListeners();
  }

  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }

  setSingleInfra(Infrastructure? infrastructure) {
      _infra = infrastructure;
      notifyListeners();
  }

  setTypeInfraId(String typeInfraId) {
    _typeinfraId = typeInfraId;
    notifyListeners();
  }


  Future<void> getInfrastructureById({required BuildContext context, required String id, required String accessToken}) async {

    setLoading(true);
    try {
      http.Response response = await ServiceInfrastructure().getInfrastructureById(context, id, accessToken);
      if (response.statusCode == 200 || response.statusCode == 201) {


        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        _infra = Infrastructure.fromJson(data);
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching infrastructure by Id: $e");
    } finally {
      setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
    }


  }



  Future<void> getAllInfrastructuresByType({required BuildContext context, required String id, required String accessToken}) async {

      setLoading(true);
      try {
        http.Response response = await ServiceInfrastructure().getAllInfrastructuresByType(context, id, accessToken);
        if (response.statusCode == 200 || response.statusCode == 201) {


          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listInfrasType = data.map((e) => Infrastructure.fromJson(e)).toList();
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching infrastructures by Type: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }


  }


  Future<void> getAllInfrastructures({required BuildContext context}) async {
    if (!_hasFetchedInfras) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServiceInfrastructure().getAllInfrastructures(context);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listInfras = data.map((e) => Infrastructure.fromJson(e)).toList();
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching infrastructures: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedInfras = true;  // Marquez que les données ont été chargées une fois
    }
  }


}