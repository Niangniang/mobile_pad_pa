import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class PayPalManager {
  final String baseUrl; // L'URL de base de votre API backend

  PayPalManager(this.baseUrl);

  Future<void> createPayment(BuildContext context) async {
    var response = await http.post(
      Uri.parse(baseUrl),  // Assurez-vous que l'URL est complète
      headers: {
        'Content-Type': 'application/json',
      },
    );
    var  code = response.statusCode ;
    debugPrint('=========================> $code');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);


      debugPrint('DATA RESP ==================> $data  =====> Code :');
      if (data['approval_url'] != null) {
        String sendUrl = data['approval_url'];
        // Ouvrir l'URL d'approbation PayPal dans un navigateur incorporé
       // launchPayPalUrl(data['approval_url']);

        _launchUrl(Uri.parse(sendUrl));
      }
    } else {
      debugPrint('Failed to create payment. Status code: ${response.statusCode}');
    }
  }


/*  Future<void> createPayment() async {
    try {
      var response = await http.post(
        Uri.parse(baseUrl),  // Assurez-vous que l'URL est complète
        headers: {
          'Content-Type': 'application/json',
        },
      ); // Supposons que cela retourne une map avec 'approval_url'
      if (response.containsKey('approval_url')) {
        String urlString = response['approval_url'];
        Uri url = Uri.parse(urlString);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.inAppWebView);
        } else {
          print('Could not launch $url');
        }
      }
    } catch (e) {
      print('Exception in createPayment: $e');
    }
  }*/






  Future<void> launchPayPalUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // This opens the URL in the default browser
      );
      if (!launched) {
        print('Failed to launch $uri');
      }
    } else {
      print('Could not launch $uri');
    }
  }



  Future<void> executePayment(String paymentId, String payerId) async {
    var response = await http.post(
      Uri.parse(baseUrl),  // Assurez-vous que l'URL est complète
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'paymentId': paymentId,
        'PayerID': payerId,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint('Payment executed successfully.');
    } else {
      debugPrint('Failed to execute payment.');
    }
  }
}

class InAppWebViewPage extends StatelessWidget {
  final String url;

  const InAppWebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PayPal Payment")),
    /*  body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
      ),*/
    );
  }
}


Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
