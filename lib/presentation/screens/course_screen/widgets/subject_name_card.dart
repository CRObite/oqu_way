import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/date_time_row.dart';

class SubjectNameCard extends StatelessWidget {
  const SubjectNameCard({super.key,required this.onButtonPressed, required this.name, required this.description, required this.hasButton});

  final VoidCallback onButtonPressed;
  final String name;
  final String description;
  final bool hasButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/ic_check.svg', height: 18,),
            const SizedBox(height: 7,),
            Container(
              color: AppColors.greenColor,
              width: 1,
              constraints: const BoxConstraints(
                maxHeight: 110,
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
              Text(name, style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
              const SizedBox(height: 12,),
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: Text(description,
                  maxLines: 4,overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.greyColor,fontSize: 11),
                ),
              ),

              const SizedBox(height: 8,),


              hasButton ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

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
                        onPressed: onButtonPressed,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppText.video, style: TextStyle(color: AppColors.blueColor, fontSize: 8),),
                          ],
                        ),
                      )
                  ),
                ],
              ): const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
