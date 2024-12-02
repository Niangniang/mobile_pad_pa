import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pad_pa/models/model_announcement/model_announcement.dart';
import 'dart:convert';
import 'package:mobile_pad_pa/models/model_notification/model_notification.dart';
import 'package:mobile_pad_pa/providers/provider_websocket/provider_websocket.dart';
import 'package:mobile_pad_pa/services/service_notification/service_notification.dart';



class AnnouncementProvider extends ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  List<Notif> _listNotifs = [];
  List<Notif> get listNotifs  => _listNotifs;

  Notif? _notification ;
  Notif? get notification  => _notification;

  bool _hasFetchedNotif = false;


  List<Announcement> _listAnnonces = [];
  List<Announcement> get listAnnonces  => _listAnnonces;


  WebSocketAnnouncementProvider? _webSocketProvider;

  void addAnnouncement(Announcement announcement) {
    _listAnnonces.insert(0, announcement);
    notifyListeners();
  }

  void setWebSocketGAProvider(WebSocketAnnouncementProvider webSocketProvider) {
    _webSocketProvider = webSocketProvider;
    _webSocketProvider!.newAnnouncementNotifier.addListener(() {
      final newAnnouncement = _webSocketProvider!.newAnnouncementNotifier.value;
      if (newAnnouncement != null) {
        addAnnouncement(newAnnouncement);
        notifyListeners();
      }
    });
  }

  setLoading(bool value) {
    if (_loading != value) { // Seulement si l'état change
      _loading = value;
      notifyListeners();
    }
  }



  setSingleInfra(Notif? announcement) {
    _notification = announcement;
    notifyListeners();
  }

  Future<void> getAllAnnouncementsByUser({required BuildContext context, required String id, required String accessToken}) async {
      setLoading(true);
      try {
        http.Response response = await ServiceNotification().getAllNotificationsByUser(context, id, accessToken );
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listNotifs = data.map((e) => Notif.fromJson(e)).toList();
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching notifications by user: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedNotif = true;  // Marquez que les données ont été chargées une fois

  }


  Future<void> getAllAnnouncements({required BuildContext context, required String accessToken}) async {
    if (!_hasFetchedNotif) {  // Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
      setLoading(true);
      try {
        http.Response response = await ServiceNotification().getAllNotifications(context, accessToken );
        if (response.statusCode == 200 || response.statusCode == 201) {
          var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
          _listNotifs = data.map((e) => Notif.fromJson(e)).toList();
        } else {
          debugPrint("Error ${jsonEncode(response.body)}");
        }
      } catch (e) {
        debugPrint("Error fetching notifications: $e");
      } finally {
        setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
      }
      _hasFetchedNotif = true;  // Marquez que les données ont été chargées une fois
    }
  }



  Future<void> getAllAnnonces({required BuildContext context, required String accessToken}) async {// Assurez-vous que _hasFetchedInfras est déclaré dans votre provider
    setLoading(true);
    try {
      http.Response response = await ServiceNotification().getAllNotifications(context, accessToken );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes)) as List<dynamic>;
        _listAnnonces = data.map((e) => Announcement.fromJson(e)).toList();
      } else {
        debugPrint("Error ${jsonEncode(response.body)}");
      }
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
    } finally {
      setLoading(false);  // Assure que setLoading est appelé pour réinitialiser l'indicateur de chargement
    }
    // Marquez que les données ont été chargées une fois
  }


}