import 'package:intl/intl.dart';

class DateEnum {
  static final Map<String, String> _daysInFrench = {
    'Monday': 'Lundi',
    'Tuesday': 'Mardi',
    'Wednesday': 'Mercredi',
    'Thursday': 'Jeudi',
    'Friday': 'Vendredi',
    'Saturday': 'Samedi',
    'Sunday': 'Dimanche',
  };

  static final Map<String, String> _monthsInFrench = {
    'January': 'Janvier',
    'February': 'Février',
    'March': 'Mars',
    'April': 'Avril',
    'May': 'Mai',
    'June': 'Juin',
    'July': 'Juillet',
    'August': 'Août',
    'September': 'Septembre',
    'October': 'Octobre',
    'November': 'Novembre',
    'December': 'Décembre',
  };

  static String formatDate(DateTime date) {
    final dayOfWeek = _daysInFrench[DateFormat('EEEE').format(date)] ?? '';
    final day = DateFormat('d').format(date);
    final month = _monthsInFrench[DateFormat('MMMM').format(date)] ?? '';
    final year = DateFormat('y').format(date);

    return '$dayOfWeek $day $month $year';
  }
}
