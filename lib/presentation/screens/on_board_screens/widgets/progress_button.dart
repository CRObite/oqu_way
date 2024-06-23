import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';

class ProgressButton extends StatelessWidget {
  const ProgressButton({super.key, required this.animation, required this.onPressed});

  final Animation<double> animation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Center(
          child: CustomPaint(
            size: const Size(100, 100),
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
            margin: const EdgeInsets.only(top: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  backgroundColor:AppColors.blueColor,
                  padding: const EdgeInsets.all(23)
              ),
              onPressed: (){
                onPressed();
              },
              child: const Icon(Icons.arrow_forward_rounded,size: 30, color: Colors.white,),
            ),
          ),
        )
      ],
    );
  }
}
