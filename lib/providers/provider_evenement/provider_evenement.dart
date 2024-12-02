
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_evenement/model_evenement.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:mobile_pad_pa/providers/provider_websocket/provider_websocket.dart';
import 'dart:convert';
import 'package:mobile_pad_pa/services/service_evenement/service_evenement.dart';
import 'package:provider/provider.dart';


class EvenementProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  Evenement? _evenement;
  Evenement? get evenement => _evenement;

  Evenement? _newEvent;
  Evenement? get newEvent => _newEvent;

  Evenement? _getedEvent;
  Evenement? get getedEvent => _getedEvent;


  List<Evenement> _listEvents = [];
  List<Evenement> get listEvents => _listEvents;

  List<Evenement> _listEventsByUser = [];
  List<Evenement> get listEventsByUser => _listEventsByUser;


  List<Evenement> _listEventsByTypeEvent= [];
  List<Evenement> get listEventsByTypeEvent => _listEventsByTypeEvent;

  String? _description;
  String? get description => _description;

  String? _nomEvent;
  String? get nomEvent => _nomEvent;




  WebSocketGestionInfraProvider? _webSocketProvider;


  void setWebSocketGIProvider(WebSocketGestionInfraProvider webSocketProvider) {
    _webSocketProvider = webSocketProvider;
    _webSocketProvider!.newEventNotifier.addListener(() {
      final newEvent = _webSocketProvider!.newEventNotifier.value;
      if (newEvent != null) {
        addEvent(newEvent);
        notifyListeners();
      }
    });
  }


  void addEvent(Evenement event) {
    _listEvents.insert(0, event);
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
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

  void setNomEvent(String nomEvent) {
    _nomEvent = nomEvent;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setEvenement(Evenement evenement) {
    _evenement = evenement;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void addEventByCurrentUser(Evenement event) {
    //_listEvents.insert(0, event);
    _listEventsByUser.insert(0, event);  // Ajouter à la liste des événements de l'utilisateur
    _sortEvents();  // Trier les listes après ajout
    notifyListeners();  // Notifier les écouteurs pour mettre à jour l'UI
  }

  void addEventByOtherUser(Evenement event) {
    _listEvents.insert(0, event);
    _sortEvents();  // Trier les listes après ajout
    notifyListeners();  // Notifier les écouteurs pour mettre à jour l'UI
  }

  void _sortEvents() {
    _listEvents.sort((a, b) => b.dateInsertion!.compareTo(a.dateInsertion!));
    _listEventsByUser.sort((a, b) => b.dateInsertion!.compareTo(a.dateInsertion!));

  }

  Future<void> addEvenement({required Map<String, dynamic> evenement, required BuildContext context,}) async {
    setLoading(true);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    EvenementProvider evenementProvider = Provider.of<EvenementProvider>(context, listen: false);
    try {
      http.Response response = await ServiceEvenement().addEvenement(
        evenement,
        authProvider.authLogin?.access ?? '',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        Evenement newEvent = Evenement.fromJson(data['Evénement']);  // Créez l'événement à partir de la réponse
       evenementProvider.addEventByCurrentUser(newEvent);  // Utilisez la méthode addEvent pour ajouter et mettre à jour

      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("add evenement failed api call: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getEvenementById({required BuildContext context, required String accessToken, required String id}) async {
    setLoading(true);

    try {
      http.Response response = await ServiceEvenement().getEvenementById(
          context,
          accessToken,
          id
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        _getedEvent = Evenement.fromJson(data);
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching event: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllEvenementsByInfra({required BuildContext context, required String id,  required String accessToken}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceEvenement().getAllEvenementsByInfra(context, id, accessToken);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listEvents = data.map((e) => Evenement.fromJson(e)).toList();
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllEvenements({required BuildContext context}) async {
    setLoading(true);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      http.Response response = await ServiceEvenement().getAllEvenements(
        context,
        authProvider.authLogin?.access ?? '',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listEvents = data.map((e) => Evenement.fromJson(e)).toList();
        _sortEvents();  // Trie les événements récupérés par date
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

  Future<void> getAllEvenementsByUser({required BuildContext context, required String accessToken, required String id}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceEvenement().getAllEvenementsByUser(
          context,
          accessToken,
          id
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listEventsByUser = data.map((e) => Evenement.fromJson(e)).toList();

        _sortEvents();  // Trie les événements récupérés par date
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

  Future<void> getAllEvenementsByTypeEvenement({required BuildContext context, required String accessToken, required String id}) async {
    setLoading(true);
    try {
      http.Response response = await ServiceEvenement().getAllEvenementsByTypeEvenemnet(
          context,
          accessToken,
          id
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listEventsByTypeEvent = data.map((e) => Evenement.fromJson(e)).toList();
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
