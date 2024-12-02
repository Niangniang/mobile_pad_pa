import 'package:flutter/material.dart';
import 'package:mobile_pad_pa/constantes/codeColors/codeColors.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String description;
  final String date;
  final String withWhom;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.description,
    required this.date,
    required this.withWhom,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        color: Colors.white,
        width: 200,
        // Définissez la largeur de la carte
        padding: const EdgeInsets.only(left: 20, top: 10, right: 40),
        // Ajoutez du padding à l'intérieur de la carte
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name, style: TypoStyle.textLabelStyleS16W500CBlack),
            Text(description, style: TypoStyle.textLabelStyleS14W400CBlack),
            Text(
              withWhom,
              style: TypoStyle.textLabelStyleS14W600CGreen,
            ),
            const SizedBox(height: 8), // Un espace entre le texte et la date
            Container(
              decoration: BoxDecoration(
                color: GlobalColors.nextonbording,
                // Déplacez la couleur de fond dans BoxDecoration
                borderRadius:
                    BorderRadius.circular(6), // Arrondit les coins du container
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 4, top: 2.5, bottom: 2.5, right: 4),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    // Un espace entre l'icône et le texte de la date
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors
                            .white, // Appliquez la couleur que vous souhaitez ici pour le texte
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ItemEvenementCard extends StatelessWidget {
  final String image;
  final String nom;
  final String date;

  const ItemEvenementCard({
    super.key,
    required this.image,
    required this.nom,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        clipBehavior: Clip
            .antiAlias, // Assurez-vous de couper les bords de l'image en dehors du card
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                child: Image.asset(
              'assets/images/youssou_concert.jpg',
              fit: BoxFit.cover,
              width: 200,
              height: 120,
            )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 6, right: 6),
              child: SizedBox(
                  child: Text(
                nom,
                style: TypoStyle.textLabelStyleS14W500CBlack,
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
              child: SizedBox(
                  child: Text(
                date,
                style: TypoStyle.textLabelStyleS14W600CGreen,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String intitule;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.intitule,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
            30), // Rayon de bordure arrondi pour l'effet d'encre
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Ajustez le padding si nécessaire
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.grey[300] : Colors.white, // Couleur de fond
            borderRadius: BorderRadius.circular(8), // Coins arrondis
            border: Border.all(
              color: Colors.grey, // Couleur de la bordure
              width: 2, // Largeur de la bordure
            ),
          ),
          child: Text(
            intitule,
            style: TextStyle(
              color: isSelected
                  ? Colors.black
                  : Colors.grey[800], // Texte noir ou gris foncé
              fontWeight: FontWeight.bold, // Texte en gras
            ),
          ),
        ),
      ),
    );
  }
}


