
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:mobile_pad_pa/models/model_infrastructure/model_infrastructure.dart';
import 'package:mobile_pad_pa/services/service_typeInfrastructure/service_typeInfrastructure.dart';



class TypeInfrastructureProvider extends ChangeNotifier {


  bool _loading = false;
  bool get loading => _loading;

  String _typeInfraId = '';
  String get typeInfraId => _typeInfraId;

  String _selectedLabel = '';
  String get selectedLabel => _selectedLabel;


  List<TypeInfrastructure> _listTypeInfrastructures = [];
  List<TypeInfrastructure> get listTypeInfrastructures  => _listTypeInfrastructures;


  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }

  setTypeInfraId(String typeInfraId) {
    _typeInfraId = typeInfraId;
    notifyListeners();
  }

  setSelectedLabel(String selectedLabel) {
    _selectedLabel = selectedLabel;
    notifyListeners();
  }








  Future<void> getAllTypeInfrastructures({required BuildContext context, required String accessToken}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceTypeInfrastructure().getAllTypeInfrastructures(context, accessToken );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listTypeInfrastructures = data.map((e) => TypeInfrastructure.fromJson(e)).toList();

      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching typeInfrastures: $e");
    } finally {
      setLoading(false);
    }

  }





}