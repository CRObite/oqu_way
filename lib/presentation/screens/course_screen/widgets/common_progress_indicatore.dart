import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({super.key, required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: percent,
        minHeight: 3,
        backgroundColor: AppColors.greyColor.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.greenColor),
      ),
    );
  }
}
