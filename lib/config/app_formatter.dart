import 'package:intl/intl.dart';

class AppFormatter {
  static String getFormattedDate(String date){
    DateFormat originalFormat = DateFormat("dd.MM.yyyy HH:mm:ss");
    DateFormat newFormat = DateFormat("dd.MM.yyyy");

    DateTime dateTime = originalFormat.parse(date);
    String formattedDate = newFormat.format(dateTime);

    return formattedDate;
  }
}