import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTime(DateTime? dateTime) {
  if (dateTime == null) return '';
  // Utilisation du format 24h
  return DateFormat('HH:mm').format(dateTime).replaceAll(':', 'h');
}

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat("d MMMM yyyy", "fr_FR").format(date);
  }
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}

String formatTimeOfDay(TimeOfDay? time) {
  if (time == null) {
    // Handle the null case appropriately
    return ''; // Or any other placeholder you want to use
  }

  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour H : $minute';
}

String getFrenchMonth(String englishMonth) {
  switch (englishMonth) {
    case 'January':
      return 'Janvier';
    case 'February':
      return 'Février';
    case 'March':
      return 'Mars';
    case 'April':
      return 'Avril';
    case 'May':
      return 'Mai';
    case 'June':
      return 'Juin';
    case 'July':
      return 'Juillet';
    case 'August':
      return 'Août';
    case 'September':
      return 'Septembre';
    case 'October':
      return 'Octobre';
    case 'November':
      return 'Novembre';
    case 'December':
      return 'Décembre';
    default:
      throw ArgumentError('Invalid englishMonth argument');
  }
}

String getFrenchWeekday(String englishWeekday) {
  switch (englishWeekday) {
    case 'Monday':
      return 'Lundi';
    case 'Tuesday':
      return 'Mardi';
    case 'Wednesday':
      return 'Mercredi';
    case 'Thursday':
      return 'Jeudi';
    case 'Friday':
      return 'Vendredi';
    case 'Saturday':
      return 'Samedi';
    case 'Sunday':
      return 'Dimanche';
    default:
      throw ArgumentError('Invalid englishWeekday argument');
  }
}
