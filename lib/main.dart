

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oqu_way/presentation/application.dart';

import 'config/app_navigation.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
  await PlatformAssetBundle().load('assets/certificates/oqutest_kz.crt');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  ByteData secondCertData =
  await PlatformAssetBundle().load('assets/certificates/_oquway_kz.crt');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(secondCertData.buffer.asUint8List());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  AppNavigation.getStatus();

  runApp(const Application());
}
