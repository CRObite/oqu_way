import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';

class UniversityCard extends StatelessWidget {
  const UniversityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: AppShadow.litherShadow
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset(
              'assets/image/university.png'
          ),
          const SizedBox(width: 17,),

          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Сулейман Демирел атындағы университет',
                    style: TextStyle(fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Мамандық саны: 10',
                    style: TextStyle(fontSize: 8,
                        color: AppColors.greyColor),
                  ),
                  Text(
                    'Алматы қаласы, Қаскелен қаласы ...',
                    style: TextStyle(fontSize: 8,
                        color: AppColors.greyColor),
                  ),
                ],
              )
          ),

          const SizedBox(width: 17,),
          Icon(Icons.arrow_forward_ios_rounded, color:AppColors.greyColor,size: 20,)
        ],
      ),
    );
  }
}
