import 'package:flutter/material.dart';

import '../../constantes/codeColors/codeColors.dart';

class NewEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imageUrl;

  const NewEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black.withOpacity(0.8),
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/noto-v1_stadium.png"),
            ),
            const SizedBox(height: 8.0),
            Text(title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(fontSize: 12)),
            Container(
                decoration: BoxDecoration(
                    color: GlobalColors.nextonbording,
                    border: Border.all(
                        color: GlobalColors.nextonbording, width: 4.0),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0))),
                child: Text(time,
                    style: const TextStyle(fontSize: 12, color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
