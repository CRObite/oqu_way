import 'package:flutter/cupertino.dart';

class AppShadow {
  static List<BoxShadow> shadow = [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      offset: Offset(0, 4),
      blurRadius: 4,
    ),
  ];

  static List<BoxShadow> textFieldShadow =  [
    const BoxShadow(
      color: Color.fromRGBO(209, 209, 214, 0.75),
      blurRadius: 10,
      spreadRadius: 2,
      offset: Offset(0, 0),
    ),
  ];

  static List<BoxShadow> cardShadow =  [
    const BoxShadow(
      color: Color.fromRGBO(70, 70, 70, 0.3),
      spreadRadius: 0,
      blurRadius: 5,
      offset: Offset(0, 0),
    ),
  ];

  static List<BoxShadow> litherShadow =  [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      blurRadius: 3.0,
      spreadRadius: 0.0,
      offset: Offset(0, 0), // changes position of shadow
    ),
  ];

}