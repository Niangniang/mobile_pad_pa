import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketHistoryItem extends StatelessWidget {
  const TicketHistoryItem({super.key});

  void _showTicketDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/ticket.png',
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement download action here
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("Télécharger"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showTicketDialog(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: CupertinoColors.lightBackgroundGray,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset('assets/images/PDF.png'),
            ),
            const SizedBox(width: 8),
            const Text(
              "Afficher le ticket",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
