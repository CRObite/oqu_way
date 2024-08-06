import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oqu_way/presentation/application.dart';
import 'config/app_navigation.dart';

class CustomHttpOverrides extends HttpOverrides {
  final HttpClient _client;

  CustomHttpOverrides(this._client);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _client;
  }
}

// class CustomHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     final client = super.createHttpClient(context);
//     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//     return client;
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {

    ByteData data = await rootBundle.load('assets/certificates/oqutest_kz.crt');
    ByteData secondCertData = await rootBundle.load('assets/certificates/_oquway_kz.crt');

    SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificatesBytes(secondCertData.buffer.asUint8List());
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());

    HttpClient customClient = HttpClient(context: context);

    HttpOverrides.global = CustomHttpOverrides(customClient);

  } catch (e) {

    print('Error loading certificates: $e');
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();

  AppNavigation.getStatus();

  runApp(const Application());
}
