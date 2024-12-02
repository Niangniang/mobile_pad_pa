import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/components/appBar/appBarAdmin.dart';
import 'package:mobile_pad_pa/components/cards/eventCard.dart';
import 'package:mobile_pad_pa/components/searchBarField.dart';

class DashBoardAminPage extends StatelessWidget {
  const DashBoardAminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Bienvenue Cheikh Ibra'),
      body: Column(
        children: [
          const SearchBarField(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: 10,  // Juste pour l'exemple
              itemBuilder: (context, index) {
                return EventCard(
                  title: "Event $index",
                  description: "Description for event $index",
                  date: "Date $index",
                  imageUrl: "https://example.com/image.png",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
