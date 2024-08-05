import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_toast.dart';
import 'package:oqu_way/data/repository/auth_reg_repository/authorization_repository.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';
import 'package:oqu_way/presentation/common/widgets/custom_text_field.dart';

import '../../../config/app_text.dart';
import '../../common/widgets/otp_form.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {

  TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.dispose();
  }

  // bool isSent = false;
  // bool isCoded = false;
  // bool isWrong = false;
  //
  // int timeInSec = 60;
  // Timer? _timer;
  //
  // void startTimer() {
  //   _timer?.cancel();
  //   timeInSec = 60;
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (timeInSec > 0) {
  //         timeInSec--;
  //       } else {
  //         _timer?.cancel();
  //       }
  //     });
  //   });
  // }

  Future<void> sendNewPassword() async {
    bool value = await AuthorizationRepository().sendCodeToEmail(emailController.text);

    if(value){
      AppToast.showToast('Сіздің поштаңызға жаңа құпия сөз жіберілді');
    }
  }

  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              // if(isCoded){
              //   setState(() {
              //     isCoded = false;
              //   });
              // }else if(isSent){
              //   setState(() {
              //     isSent = false;
              //   });
              // }else{
              //   context.pop();
              // }

              context.pop();

            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: const Text('Құпиясөзді қалпына келтіру', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: // !isSent && !isCoded ?
        Column(
          children: [
            CustomTextField(title: AppText.enterEmail, controller: emailController, type: TextInputType.emailAddress, hint: AppText.email, isTabled: isTablet,),
            const SizedBox(height: 20,),
            CommonButton(title: 'Растау', onClick: (){
              setState(() {
                // startTimer();
                // isSent = true;

                if(emailController.text.isNotEmpty){
                  sendNewPassword();
                }else{
                  AppToast.showToast('Поштаны толтырыңыз');
                }

              });
            })
          ],
        )
        //     : isSent && !isCoded ?  Column(
        //   children: [
        //     const Text('Сіздің поштаңызға код жіберілді.',style: TextStyle(fontSize: 12),),
        //     timeInSec > 0 ?
        //     Text('$timeInSec секундтан кейін қайта код алу', style: const TextStyle(fontSize: 12),)
        //         :
        //     GestureDetector(
        //       onTap: startTimer,
        //         child: Text('Кодты қайта алу', style: TextStyle(
        //               fontSize: 12, color: AppColors.blueColor),
        //         ),
        //     ),
        //     const SizedBox(height: 20,),
        //
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 70),
        //       child: OtpForm(onOtpEntered: (String value) {
        //         print(value);
        //
        //         if(_timer!= null && _timer!.isActive){
        //           _timer!.cancel();
        //         }
        //         setState(() {
        //           isCoded = true;
        //         });
        //         },
        //         isWrong: isWrong,
        //       ),
        //     ),
        //
        //
        //
        //   ],
        // ): Column(
        //   children: [
        //     CustomTextField(
        //         title:  AppText.enterPassword ,
        //         controller: passwordController,
        //         type: TextInputType.visiblePassword,
        //         hint:AppText.password),
        //     const SizedBox(height: 20,),
        //     CustomTextField(
        //         title:  AppText.enterPasswordAgain ,
        //         controller: confirmPasswordController,
        //         type: TextInputType.visiblePassword,
        //         hint:AppText.password
        //     ),
        //     const SizedBox(height: 20,),
        //     CommonButton(title: 'Растау', onClick: (){
        //       context.pop();
        //     })
        //   ],
        // ),
      ),
    );
  }
}
