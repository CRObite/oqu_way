import 'package:flutter/material.dart';

import '../../../../config/app_shadow.dart';

class ProfilePartCard extends StatelessWidget {
  const ProfilePartCard({super.key, required this.title, required this.onTaped});

  final String title;
  final VoidCallback onTaped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onTaped();},
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: AppShadow.cardShadow
        ),
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        child: Row(
          children: [
            Text(title,style: const TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
