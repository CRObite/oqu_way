

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/confirm_dialog.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/profile_part_card.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';
import '../../../util/image_picker_helper.dart';
import '../../common/widgets/common_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  late AnimationController animationController;
  late Animation<double> animation;

  double initialTopContainerHeight = 260.0;
  double collapsedTopContainerHeight = 120.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define the animation tween
    animation = Tween<double>(
      begin: initialTopContainerHeight,
      end: collapsedTopContainerHeight,
    ).animate(animationController);
    scrollController.addListener(() {
      // if (scrollController.offset > 30) {
      //   scrollController.jumpTo(30);
      // }
    });
    // Listen to scroll changes
    scrollController.addListener(() {

      // if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      //   if (!animationController.isAnimating && animationController.status == AnimationStatus.completed) {
      //     animationController.reverse(); // Reverse the animation when scrolling up
      //   }
      // } else {
      //   if (!animationController.isAnimating && animationController.status == AnimationStatus.dismissed) {
      //     animationController.forward(); // Forward the animation when scrolling down
      //   }
      // }
    });
  }


  void _displayImageSource() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 54,
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 6,
                      decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: const BorderRadius.all(Radius.circular(50))
                      ),
                    ),
                  ),
                ),
                Divider(color: AppColors.greyColor),

                Padding(
                    padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Uint8List? image = await  ImagePickerHelper().pickImageBytesFromGallery();

                          print(image);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.photo_outlined, color: AppColors.blueColor,size: 30,),
                            const SizedBox(width: 25,),
                            const Text('Галерея',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async {
                          Uint8List? image = await  ImagePickerHelper().pickImageBytesFromCamera();

                          print(image);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined, color: AppColors.blueColor,size: 30,),
                            const SizedBox(width: 25,),
                            const Text('Камера',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: [
                            Icon(Icons.person_outline_rounded, color: AppColors.blueColor,size: 30,),
                            const SizedBox(width: 25,),
                            const Text('Аваны өшіру',style: TextStyle(fontSize: 16,color: Colors.red),)
                          ],
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },
    ).whenComplete(() {

    });
  }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // controller: scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Container(
                  height: animation.value,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    boxShadow: AppShadow.shadow,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: animation.isDismissed ? 8 : 0),
                                  child: Container(
                                    width: animation.isDismissed ? 100 : 40,
                                    height: animation.isDismissed ? 100 : 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(animation.isDismissed ? 20 : 5)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'A',
                                        style: TextStyle(
                                          color: AppColors.greenColor,
                                          fontSize: animation.isDismissed ? 40 : 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                animation.isDismissed
                                    ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: (){
                                      _displayImageSource();},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(child: Icon(Icons.add, color: Colors.white)),
                                    ),
                                  ),
                                )
                                    : const SizedBox(),
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                context.push('/notificationPage');
                              },
                                child: SvgPicture.asset('assets/icons/ic_notification.svg', height: 18,)
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7,),
                      animation.isDismissed ? const Text('Алуа Алпысбаева', style: TextStyle(color: Colors.white, fontSize: 20),) : const SizedBox(),
                      animation.isDismissed ? const Text('оқушы', style: TextStyle(color: Colors.white),) : const SizedBox(),
                    ],
                  ),
                );
              },
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [

                ProfilePartCard(title: AppText.data, onTaped: () { context.push('/profilePage/profileDetails'); },),
                ProfilePartCard(title: AppText.rating, onTaped: () { context.push('/profilePage/profileRating'); },),
                ProfilePartCard(title: AppText.attends, onTaped: () { context.push('/profilePage/profileAttends'); },),
                // ProfilePartCard(title: AppText.universities, onTaped: () { context.push('/profilePage/profileUniversity'); },),
                ProfilePartCard(title: AppText.analysis, onTaped: () { context.push('/profilePage/profileAnalysis'); },),
                // ProfilePartCard(title: AppText.questions, onTaped: () { context.push('/profilePage/profileQuestions'); },),

                GestureDetector(
                  onTap: (){
                    ConfirmDialog.showConfirmationDialog(
                        context,
                        'Сіз профиліңізді жоюға сенімдісізбе?',
                        'Иә, жою',
                        'Жоқ',
                            (){
                          context.go('/loginPage');
                        }
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: AppColors.blueColor
                      ),
                        color: AppColors.blueColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                    child: Row(
                      children: [
                        Text('Аккаунтты жою',style: TextStyle(fontSize: 14,color: AppColors.blueColor,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                
                GestureDetector(
                  onTap: (){
                    ConfirmDialog.showConfirmationDialog(
                        context,
                        'Сіз профиліңізден шығуға сенімдісізбе?',
                        'Иә, шығу',
                        'Жоқ',
                        (){
                          context.go('/loginPage');
                        }
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: AppShadow.cardShadow
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                    child: const Row(
                      children: [
                        Text('Шығу',style: TextStyle(fontSize: 14,color: Colors.white),)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
