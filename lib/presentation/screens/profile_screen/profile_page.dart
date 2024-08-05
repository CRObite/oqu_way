

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/repository/auth_reg_repository/authorization_repository.dart';
import 'package:oqu_way/domain/media_file.dart';
import 'package:oqu_way/presentation/common/confirm_dialog.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/profile_part_card.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';
import '../../../data/local/shared_preferences_operator.dart';
import '../../../data/repository/ent_test_repository/ent_test_repository.dart';
import '../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../domain/app_user.dart';
import '../../../domain/ent_test.dart';
import '../../../util/image_picker_helper.dart';
import '../../common/widgets/common_button.dart';
import '../news_screen/widgets/news_card.dart';

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


  AppUser? user;

  Future<void> getUsername() async {
    String? token = await SharedPreferencesOperator.getAccessToken();
    AppUser? value = await AuthorizationRepository().userGetMe(token!);

    setState(() {
      user = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
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
            height: MediaQuery.of(context).size.height * 0.25,
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
                          String? imagePath = await  ImagePickerHelper().pickImageBytesFromGallery();

                          String? token = await SharedPreferencesOperator.getAccessToken();

                          if(imagePath!= null){
                            MediaFile? value = await MediaFileRepository().uploadFile(token!, imagePath, type: 'Avatar');

                            getUsername();
                          }

                          context.pop();
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
                          String? imagePath = await  ImagePickerHelper().pickImageBytesFromCamera();

                          String? token = await SharedPreferencesOperator.getAccessToken();

                          if(imagePath!= null){
                            MediaFile? value = await MediaFileRepository().uploadFile(token!, imagePath, type: 'Avatar');

                            getUsername();
                          }

                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt_outlined, color: AppColors.blueColor,size: 30,),
                            const SizedBox(width: 25,),
                            const Text('Камера',style: TextStyle(fontSize: 16),)
                          ],
                        ),
                      ),

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

  // Future<void> getEntMistake() async {
  //
  //   String? token = await SharedPreferencesOperator.getAccessToken();
  //
  //   EntTest? value = await EntTestRepository().getMistakes(token!,'27aa30ec-b882-47f6-a473-d5e75b2f6e72');
  //
  //   context.push('/testResults/testMistakeWork',extra: {'test_mistake': value});
  // }

  @override
  void dispose() {
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;
    bool isSmall = MediaQuery.of(context).size.width <= 360;

    return WillPopScope(
      onWillPop: () async {
        context.pop(true);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          // controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Container(
                    height: isSmall? 220: isTablet ?  300 : animation.value,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      boxShadow: AppShadow.shadow,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: user!= null? Column(
                      children: [
                        const SizedBox(height: 60,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                  context.pop(true);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: isTablet ? 28 : 18,
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: animation.isDismissed ? 8 : 0),
                                    child: user!.avatar != null ? Container(
                                      width: isSmall? 70: animation.isDismissed ? 100 : 40,
                                      height: isSmall? 70: animation.isDismissed ? 100 : 40,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(animation.isDismissed ? 20 : 5)),
                                        child: FutureBuilder<Uint8List?>(
                                          future: MediaFileRepository().downloadFile(user!.avatar!.split('/').last),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return SizedBox(
                                                  height: isSmall? 70: animation.isDismissed ? 100 : 40, width: double.infinity,
                                                  child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,)));
                                            } else if (snapshot.hasError) {
                                              return  NoImagePhoto(width: isSmall? 70:animation.isDismissed ? 100 : 40, height: animation.isDismissed ? 100 : 40,);
                                            } else if (!snapshot.hasData) {
                                              return  NoImagePhoto(width: isSmall? 70:animation.isDismissed ? 100 : 40, height: animation.isDismissed ? 100 : 40);
                                            } else {
                                              return Image.memory(snapshot.data!, fit: BoxFit.cover,width: isSmall? 70:animation.isDismissed ? 100 : 40, height: animation.isDismissed ? 100 : 40,);
                                            }
                                          },
                                        ),
                                      ),
                                    ):Container(
                                      width: animation.isDismissed ? 100 : 40,
                                      height: animation.isDismissed ? 100 : 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(animation.isDismissed ? 20 : 5)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          user!.login!= null ? user!.login![0] : '?',
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
                              // GestureDetector(
                              //   onTap: (){
                              //     context.push('/notificationPage');
                              //   },
                              //     child: SvgPicture.asset('assets/icons/ic_notification.svg', height: 18,)
                              // ),
                              const SizedBox(width: 30,),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7,),
                        animation.isDismissed ? Text(user!.login ?? '?', style: const TextStyle(color: Colors.white, fontSize: 20),) : const SizedBox(),
                        animation.isDismissed ? const Text('оқушы', style: TextStyle(color: Colors.white),) : const SizedBox(),
                      ],
                    ): const SizedBox() ,
                  );
                },
              ) ,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [

                  ProfilePartCard(title: AppText.data, onTaped: () async {
                    var  value = await  context.push('/profilePage/profileDetails');
                    if(value!= null){
                      getUsername();
                    }
                  },),
                  ProfilePartCard(title: AppText.rating, onTaped: () { context.push('/profilePage/profileRating'); },),
                  // ProfilePartCard(title: AppText.attends, onTaped: () { context.push('/profilePage/profileAttends'); },),
                  // ProfilePartCard(title: AppText.universities, onTaped: () { context.push('/profilePage/profileUniversity'); },),
                  // ProfilePartCard(title: AppText.analysis, onTaped: () { context.push('/profilePage/profileAnalysis'); },),
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

                            SharedPreferencesOperator.clearCurrentUser();
                            SharedPreferencesOperator.clearAccessToken();
                            SharedPreferencesOperator.clearRefreshToken();

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
      ),
    );
  }
}
