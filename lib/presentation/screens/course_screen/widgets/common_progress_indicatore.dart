import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: 0.6,
        minHeight: 3,
        backgroundColor: AppColors.greyColor.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.greenColor),
      ),
    );
  }
}
