import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key, required this.title, required this.onClick, this.fontSize = 16, this.verticalPadding = 14, this.horizontalPadding = 12, this.radius = 5, this.color = Colors.white,});

  final String title;
  final VoidCallback onClick;
  final double fontSize;
  final double verticalPadding;
  final double horizontalPadding;
  final double radius;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor:color == Colors.white ?  AppColors.blueColor : color,
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
