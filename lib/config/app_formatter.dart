import 'package:intl/intl.dart';

class AppFormatter {
  static String getFormattedDate(String date){
    DateFormat originalFormat = DateFormat("dd.MM.yyyy HH:mm:ss");
    DateFormat newFormat = DateFormat("dd.MM.yyyy");

    DateTime dateTime = originalFormat.parse(date);
    String formattedDate = newFormat.format(dateTime);

    return formattedDate;
  }

  static String formatPhoneNumber(String phoneNumber) {
    final RegExp regExp = RegExp(r'\D');
    String digitsOnly = phoneNumber.replaceAll(regExp, '');

    if (digitsOnly.startsWith('7')) {
      digitsOnly = digitsOnly.substring(1);
    }

    return digitsOnly;
  }

  static String formatBackPhoneNumber(String phoneNumber) {
    final RegExp regExp = RegExp(r'\D');
    String digitsOnly = phoneNumber.replaceAll(regExp, '');


    // Check if the number has the correct length
    if (digitsOnly.length != 10) {
      throw const FormatException('Phone number must have 10 digits after removing non-digits.');
    }

    // Format the phone number
    final String formattedNumber = '+7 (${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)} - ${digitsOnly.substring(6, 8)} - ${digitsOnly.substring(8)}';
    return formattedNumber;
  }
}