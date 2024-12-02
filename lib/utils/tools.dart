import 'package:flutter/cupertino.dart';

import '../models/model_creneau/model_creneau.dart';

String replaceSpaceWithT(String input) {
  return input.replaceFirst(' ', 'T');
}

bool estDisponible(List<CreneauEvent> creneauxExistants,
    DateTime nouvelleDateDebut, DateTime nouvelleDateFin) {
  debugPrint("Date debut ==================>$nouvelleDateDebut");
  debugPrint("Date fin ==================>$nouvelleDateFin");
  for (var creneau in creneauxExistants) {
    debugPrint("Date debut boucle ==================>${creneau.dateDebut}");
    debugPrint("Date fin  boucle==================>${creneau.dateFin}");
    // Vérifier si les créneaux se chevauchent
    if (!(nouvelleDateFin.isBefore(creneau.dateDebut!) ||
        nouvelleDateDebut.isAfter(creneau.dateFin!))) {
      return false; // Il y a un chevauchement
    }
  }
  return true; // Aucun chevauchement trouvé
}

String capitalizeAndReplaceUnderscore(String input) {
  // Remplacer les underscores par des espaces
  String formatted = input.replaceAll('_', ' ');

  // Convertir en minuscules, puis capitaliser la première lettre
  if (formatted.isNotEmpty) {
    formatted = formatted.toLowerCase();
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  return formatted; // Retourne la chaîne formatée
}
