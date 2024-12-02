
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constantes/api_base_url.dart';

class ServiceFirebase {



  Future<http.Response> saveTokensFirebase(Map<String, dynamic> data , String accessToken) async {
    try {
      var url = Uri.parse("$uri/user/addToken_firebase");
      final response = await http.patch(
        url,
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          debugPrint("Success add token firebase");
          return response;
        default:
          debugPrint("Failed to save token firebase: ${response.statusCode}");
          return response;
      }
    } on Exception catch (e) {
      debugPrint("save token firebase failed api call: $e");
      rethrow;
    }
  }


  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    //await Firebase.initializeApp(); // Assurez-vous que Firebase est initialisé
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint("Handling a background message title: ${message.notification?.title}");
    debugPrint("Handling a background message body: ${message.notification?.body}");
    debugPrint("Handling a background message data: ${message.data}");
  }

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("Token ==> $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

