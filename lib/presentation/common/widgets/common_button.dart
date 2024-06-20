import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key, required this.title, required this.onClick, this.fontSize = 16, this.verticalPadding = 14, this.horizontalPadding = 12});

  final String title;
  final VoidCallback onClick;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.blueColor,
        padding: EdgeInsets.symmetric(vertical: verticalPadding,horizontal: horizontalPadding),
      ),
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: fontSize),),
        ],
      ),
    );
  }
}
