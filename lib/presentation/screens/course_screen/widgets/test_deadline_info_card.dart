import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/date_time_row.dart';

import '../../../../config/app_colors.dart';

class TestDeadlineInfoCard extends StatelessWidget {
  const TestDeadlineInfoCard({super.key, required this.isTest, required this.onPressed});

  final bool isTest;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(left: 40),
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/ic_red_mark.svg', height: 18,),
              const SizedBox(height: 7,),
              Expanded(
                child: Container(
                  color: AppColors.greenColor,
                  width: 1,
                ),
              ),
              const SizedBox(height: 7,),
            ],
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isTest? AppText.test: AppText.homeworks, style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                const SizedBox(height: 6,),
                Text(isTest?'${AppText.time}:': '${AppText.deadline}:', style: TextStyle(fontSize: 13, color: AppColors.greyColor)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    isTest? Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_time.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                          height: 15,
                        ),
                        const SizedBox(width: 9,),
                        const Text('40 мин', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ) :const DateTimeRow(),

                    SizedBox(
                        height: 30,
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: AppColors.blueColor, width: 1),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 14),
                          ),
                          onPressed: onPressed,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppText.doIt, style: TextStyle(color: AppColors.blueColor, fontSize: 8),),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
