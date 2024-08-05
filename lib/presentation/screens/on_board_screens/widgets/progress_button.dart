import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';

class ProgressButton extends StatelessWidget {
  const ProgressButton({super.key, required this.animation, required this.onPressed});

  final Animation<double> animation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    bool isSmall = MediaQuery.of(context).size.width <= 360;

    return Stack(
      children: [

        Center(
          child: CustomPaint(
            size: Size(isSmall? 65: 90, isSmall? 65: 90),
            painter: RoundedCircularProgressIndicator(
              value: animation.value,
              color: AppColors.blueColor.withOpacity(0.5),
              strokeWidth: 8,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),

        Center(
          child: Container(
            width: isSmall? 45 : null,
            margin: EdgeInsets.only(top: isSmall? 8 : 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  backgroundColor:AppColors.blueColor,
                  padding: EdgeInsets.all( isSmall? 15 : 23)
              ),
              onPressed: (){
                onPressed();
              },
              child: Icon(Icons.arrow_forward_rounded, size: isSmall? 15: 20, color: Colors.white,),
            ),
          ),
        )
      ],
    );
  }
}
