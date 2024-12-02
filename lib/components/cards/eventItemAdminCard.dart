import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';

class ItemEventAdminCard extends StatefulWidget {
  final String state;
  final String title;
  final String imagePath;
  final String description;
  final String date;
  final VoidCallback onTap; // Ajout de la fonction de rappel onTap

  const ItemEventAdminCard({
    super.key,
    required this.state,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.date,
    required this.onTap, // Ajout de la fonction de rappel onTap
  });

  @override
  State<ItemEventAdminCard> createState() => _ItemEventAdminCardState();
}

class _ItemEventAdminCardState extends State<ItemEventAdminCard> {
  @override
  Widget build(BuildContext context) {
    // Déterminer le texte et la couleur en fonction de l'état
    String eventText;
    Color backgroundColor;

    switch (widget.state) {
      case 'annulé':
        eventText = 'Evenement annulé';
        backgroundColor = Colors.red;
        break;
      case 'à venir':
        eventText = 'Evenement à venir';
        backgroundColor = GlobalColors.nextonbording;
        break;
      case 'passé':
        eventText = 'Evenement passé';
        backgroundColor = Colors.orangeAccent;
        break;
      default:
        eventText = '==Evenement==';
        backgroundColor = Colors.black45;
    }

    return GestureDetector(
      onTap: widget.onTap, // Utilisation de la fonction de rappel onTap
      child: Flexible(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black45,
              width: 1.0,
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 400,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(widget.imagePath),
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            width: 120,
                            height: 25,
                            top: 15,
                            left: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.0,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12.0),
                                color: backgroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 8.0),
                                child: Text(
                                  eventText,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: GlobalColors.nextonbording),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.date,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
