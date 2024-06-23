import 'package:flutter/material.dart';
import 'package:oqu_way/presentation/screens/news_screen/news_page.dart';

import '../config/app_navigation.dart';
import '../util/scale_size.dart';
import '../util/scroll_behavior.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: CustomScrollBehavior(),
      title: 'OQUWAY',
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          child: SafeArea(
            child: child!,
          ),
        );
      },
    );
  }
}
