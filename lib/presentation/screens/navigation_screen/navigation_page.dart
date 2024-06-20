import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/custom_app_bar.dart';
import '../../common/widgets/custom_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {


  void _goToBranch( int index) {
    widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onBellPressed: (){},
        title: 'Алуа Алпысбаева',
        imageId: '',
        setDot: true,
      ),
      body: Stack(
        children:[

          widget.navigationShell,

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomNavBar(
              onNavigation: (int value) {
                _goToBranch(value);
              },
            ),
          ),
        ]
      ),
    );
  }
}
