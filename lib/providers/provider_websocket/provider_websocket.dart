import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/models/model_announcement/model_announcement.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../models/model_evenement/model_evenement.dart';

class WebSocketGestionInfraProvider with ChangeNotifier {

  late WebSocketChannel _channel;
  bool _isConnected = false;


  final ValueNotifier<Evenement?> newEventNotifier = ValueNotifier<Evenement?>(null);


  final List<Evenement> _listEvents = [];
  List<Evenement> get listEvents => _listEvents;





  WebSocketGestionInfraProvider() {
    initializeWebSocket();
  }


  void initializeWebSocket() {
    debugPrint("=======> Initialisation de la connexion WebSocket...");
    _connect();
  }

  void _connect() {
    try {
      debugPrint("=======> Tentative de connexion au serveur WebSocket...");
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://bregitsonvm2.francecentral.cloudapp.azure.com:8011/ws'), // WebSocket server address
      );
      _isConnected = true;
      debugPrint("=======> Connexion WebSocket établie.");

      // Listen for messages from the WebSocket
      _channel.stream.listen((data) {
        debugPrint("Donnees reçues ===========> $data");
          _handleNewEvent(jsonDecode(data));
        },
        onDone: () {
          debugPrint("=======> La connexion WebSocket est fermée.");
          _isConnected = false;
          _reconnect(); // Attempt to reconnect if the connection is closed
        },
        onError: (error) {
          debugPrint("=======> Erreur WebSocket : $error");
          _isConnected = false;
         _reconnect(); // Attempt to reconnect in case of an error
        },
      );
    } catch (e) {
      debugPrint("=======> Erreur lors de la tentative de connexion WebSocket: $e");
     _reconnect();
    }
  }

  void _handleNewEvent(Map<String, dynamic> jsonData) {
    debugPrint("Les données reçues dans le WS : $jsonData");

    if (jsonData['event'] == 'nouveau_evenement_cree'){

      final newEvent = Evenement.fromJson(jsonData['data']);
      debugPrint("Nouvel événement reçu : $newEvent");
      newEventNotifier.value = newEvent;

    }
  }



  void _reconnect() {
    if (!_isConnected) {
      debugPrint("=======> Tentative de reconnexion dans 3 secondes...");
      Future.delayed(const Duration(seconds: 3), () {
        _connect();
      });
    }
  }

  void sendMessage(String message) {
    if (_isConnected) {
      _channel.sink.add(message);
      debugPrint("=======> Message envoyé via WebSocket : $message");
    } else {
      debugPrint("=======> Impossible d'envoyer le message. WebSocket non connecté.");
    }
  }

  void closeConnection() {
    debugPrint("=======> Fermeture de la connexion WebSocket.");
    _channel.sink.close();
  }

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }
}



class WebSocketAnnouncementProvider with ChangeNotifier {

  late WebSocketChannel _channel;
  bool _isConnected = false;


  final ValueNotifier<Announcement?> newAnnouncementNotifier = ValueNotifier<Announcement?>(null);


  final List<Announcement> _listAnnonces = [];
  List<Announcement> get listAnnonces => _listAnnonces;





  WebSocketAnnouncementProvider() {
    initializeWebSocket();
  }


  void initializeWebSocket() {
    debugPrint("=======> Initialisation de la connexion WebSocket GA...");
    _connect();
  }

  void _connect() {
    try {
      debugPrint("=======> Tentative de connexion au serveur WebSocket GA ...");
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://bregitsonvm2.francecentral.cloudapp.azure.com:8012/ws'), // WebSocket server address
      );
      _isConnected = true;
      debugPrint("=======> Connexion WebSocket GA établie.");

      // Listen for messages from the WebSocket
      _channel.stream.listen((data) {
        debugPrint("Donnees reçues GA ===========> $data");
        _handleAnnouncement(jsonDecode(data));
      },
        onDone: () {
          debugPrint("=======> La connexion WebSocket GA est fermée.");
          _isConnected = false;
          _reconnect(); // Attempt to reconnect if the connection is closed
        },
        onError: (error) {
          debugPrint("=======> Erreur WebSocket  GA: $error");
          _isConnected = false;
          _reconnect(); // Attempt to reconnect in case of an error
        },
      );
    } catch (e) {
      debugPrint("=======> Erreur lors de la tentative de connexion WebSocket GA: $e");
      _reconnect();
    }
  }

  void _handleAnnouncement(Map<String, dynamic> jsonData) {
    debugPrint("Les données reçues dans le WS GA: $jsonData");

     if(jsonData['event'] == 'nouvelle_annonce_cree'){

      final newAnnouncement = Announcement.fromJson(jsonData['data']);
      debugPrint("Nouvelle annonce reçue : $newAnnouncement");
      newAnnouncementNotifier.value = newAnnouncement;
    }
  }



  void _reconnect() {
    if (!_isConnected) {
      debugPrint("=======> Tentative de reconnexion dans 3 secondes GA...");
      Future.delayed(const Duration(seconds: 3), () {
        _connect();
      });
    }
  }

  void sendMessage(String message) {
    if (_isConnected) {
      _channel.sink.add(message);
      debugPrint("=======> Message envoyé via WebSocket GA: $message");
    } else {
      debugPrint("=======> Impossible d'envoyer le message. WebSocket GA non connecté.");
    }
  }

  void closeConnection() {
    debugPrint("=======> Fermeture de la connexion WebSocket GA.");
    _channel.sink.close();
  }

  @override
  void dispose() {
    closeConnection();
    super.dispose();
  }
}
