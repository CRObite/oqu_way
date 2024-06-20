import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.onBellPressed, required this.title, required this.imageId, this.setDot = false});

  final VoidCallback onBellPressed;
  final String title;
  final String imageId;
  final bool setDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        boxShadow: AppShadow.shadow,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 14),
          child: Row(
            children: [

              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: imageId.isNotEmpty ? Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ): Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Center(child: Text(title[0])),
                    ),
                  ),

                  setDot ? Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ): const SizedBox(),


                ],
              ),

              const SizedBox(width: 18,),


              Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                    ),
                  )
              ),

              const SizedBox(width: 18,),

              IconButton(
                onPressed:onBellPressed,
                icon: SvgPicture.asset('assets/icons/ic_notification.svg', height: 16,)
              )



            ],
          ),
        ),
      ),
    );
}

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(96.0);
}
