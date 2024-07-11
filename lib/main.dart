import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oqu_way/config/app_navigation.dart';
import 'package:oqu_way/firebase_options.dart';
import 'package:oqu_way/presentation/application.dart';

import 'data/local/shared_preferences_operator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AppNavigation.getStatus();

  runApp(const Application());
}
