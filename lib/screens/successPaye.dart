//import 'package:flutter/material.dart';

/*
class PaymentSuccessPage extends StatelessWidget {
  final String transactionId; // Identifiant de transaction si nécessaire
  final double amount; // Montant payé si vous voulez l'afficher

  const PaymentSuccessPage({super.key, required this.transactionId, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement Réussi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.0,
            ),
            const SizedBox(height: 20),
            const Text(
              'Votre paiement a été effectué avec succès.',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Identifiant de transaction: $transactionId',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 5),
            Text(
              'Montant: \$${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Retourner à la page précédente ou à l'accueil
              },
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
