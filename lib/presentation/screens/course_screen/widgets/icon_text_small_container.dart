import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_colors.dart';

class IconTextSmallContainer extends StatelessWidget {
  const IconTextSmallContainer({super.key, required this.iconPath, required this.title});

  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.3),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 11),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, height: 14,),
            const SizedBox(width: 10,),
            Text(title,style: const TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
