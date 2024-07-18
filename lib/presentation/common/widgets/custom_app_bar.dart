import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../domain/face_subject.dart';
import '../../screens/news_screen/widgets/news_card.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.onBellPressed, required this.title, required this.imageId, this.setDot = false});

  final VoidCallback onBellPressed;
  final String title;
  final String imageId;
  final bool setDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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

              GestureDetector(
                onTap: (){
                  context.push('/profilePage');
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: imageId.isNotEmpty ? Container(
                        width: 35, height: 35,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: FutureBuilder<Uint8List?>(
                            future: MediaFileRepository().downloadFile(imageId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return SizedBox(
                                    height: 70, width: double.infinity,
                                    child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,)));
                              } else if (snapshot.hasError) {
                                return const NoImagePhoto(width: 35, height: 35,);
                              } else if (!snapshot.hasData) {
                                return const NoImagePhoto(width: 35, height: 35);
                              } else {
                                return Image.memory(snapshot.data!, fit: BoxFit.cover,width: 35,);
                              }
                            },
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
