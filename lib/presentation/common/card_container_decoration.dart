
import 'package:flutter/material.dart';

import '../../config/app_shadow.dart';

class CardContainerDecoration{
  static BoxDecoration decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: AppShadow.cardShadow
  );
}