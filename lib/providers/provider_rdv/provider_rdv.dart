import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_rdv/model_rdv.dart';
import 'dart:convert';
import 'package:mobile_pad_pa/services/service_rdv/service_rdv.dart';
import 'package:provider/provider.dart';



class RDVProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  RDV? _rdv;
  RDV? get rdv => _rdv;


  dynamic _rdvAdded;
  dynamic get rdvAdded => _rdvAdded;

  RDV? _getedRDV;
  RDV? get getedRDV => _getedRDV;

  String? _typeRDV;
  String? get typeRDV => _typeRDV;

  String? _description;
  String? get description => _description;

  DateTime? _dateRDV;
  DateTime? get dateRDV => _dateRDV;

  String? _objetRDVID;
  String? get objetRDVID => _objetRDVID;

  String? _objetRDVItem;
  String? get objetRDVItem => _objetRDVItem;

  Creneau? _creneau;
  Creneau? get creneau => _creneau;


  List<RDV> _listRDVsByUser = [];
  List<RDV> get listRDVsByUser => _listRDVsByUser;

  setLoading(bool value) {
    _loading = value;
    // Post-frame callback to ensure this runs after the current frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setRDV(RDV rdv) {
    _rdv = rdv;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
  void setObjetRDVID(String objetRDVID) {
    _objetRDVID = objetRDVID;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setObjetRDVItem(String objetRDVItem) {
    _objetRDVItem= objetRDVItem;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


  void setRDVAdded(dynamic data) {
    _rdvAdded = data;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setDescription(String description) {
    _description = description;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setTypeRDV(String typeRDV){
    _typeRDV = typeRDV;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

  }


  void setDateRDV(DateTime dateDRV){
    _dateRDV = dateDRV;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

  }

  void _sortRDVs() {
    _listRDVsByUser.sort((a, b) => b.date!.compareTo(a.date!));
  }


  void addRDVByCurrentUser(RDV rdv) {
    _listRDVsByUser.insert(0, rdv);  // Ajouter à la liste des événements de l'utilisateur// Trier les listes après ajout
    _sortRDVs();
    notifyListeners();  // Notifier les écouteurs pour mettre à jour l'UI
  }


  void removeRDVByCurrentUser(RDV rdv) {
    // Suppression basée sur l'ID
    _listRDVsByUser.removeWhere((item) => item.id == rdv.id);

    // Trier la liste après suppression (si nécessaire)
    _sortRDVs();
    notifyListeners();  // Mettre à jour l'UI
  }

  Future<void> addRDV({required Map<String, dynamic> rdv, required BuildContext context, required String accessToken}) async {
    setLoading(true);
    RDVProvider rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    try {
      http.Response response = await ServiceRDV().addRDV(
        rdv,
        accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        debugPrint('Data RDV ======> $data');
        RDV newRDV = RDV.fromJson(data);  // Créez l'événement à partir de la réponse
        rdvProvider.addRDVByCurrentUser(newRDV);  // Utilisez la méthode addEvent pour ajouter et mettre à jour


      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("add rdv failed api call: $e");
    } finally {
      setLoading(false);
    }
  }


  Future<void> annulerRDV({required String id, required BuildContext context, required String accessToken}) async {
    setLoading(true);
    RDVProvider rdvProvider = Provider.of<RDVProvider>(context, listen: false);
    try {
      http.Response response = await ServiceRDV().annulerRDV(
        id,
        accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        debugPrint('Data RDV rsponse ======> $data');
        RDV newRDV = RDV.fromJson(data);

        // Avant de supprimer, affichez les détails de l'objet RDV
        debugPrint('Trying to remove RDV with ID: ${newRDV.id}');
        rdvProvider.removeRDVByCurrentUser(newRDV);  // Utilisez la méthode addEvent pour ajouter et mettre à jour

      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("add rdv failed api call: $e");
    } finally {
      setLoading(false);
    }
  }


  Future<void> getRDVById({required BuildContext context, required String accessToken, required String id}) async {
    setLoading(true);

    try {
      http.Response response = await ServiceRDV().getRDVById(
          context,
          accessToken,
          id
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

        debugPrint('=================> data $data');

        _getedRDV = RDV.fromJson(data);

        debugPrint('=================> getedEvent $_getedRDV');
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching rdv: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllRDVs({required BuildContext context, required String accessToken}) async {
    setLoading(true);

    try {
      http.Response response = await ServiceRDV().getAllRDVs(
        context,
        accessToken,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listRDVsByUser = data.map((e) => RDV.fromJson(e)).toList();
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching RDVs: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllRDVsByUser({required BuildContext context, required String accessToken, required String id}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceRDV().getAllRDVsByUser(
          context,
          accessToken,
          id
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listRDVsByUser = data.map((e) => RDV.fromJson(e)).toList();
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching RDVs: $e");
    } finally {
      setLoading(false);
    }
  }
}
