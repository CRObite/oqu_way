import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';

import '../../config/app_shadow.dart';
import '../common/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppText.welcome,
              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32,),
            CustomTextField(title: AppText.enterEmail, controller: emailController, type: TextInputType.emailAddress, hint:AppText.email,),
            const SizedBox(height: 20,),
            CustomTextField(title:  AppText.enterPassword , controller: passwordController, type: TextInputType.visiblePassword, hint:AppText.password),
            TextButton(
                onPressed: (){},
                child: Text(AppText.forgotPassword, style: TextStyle(fontSize: 10, color: AppColors.blueColor),)
            ),
            const SizedBox(height: 20,),
            CommonButton(title: AppText.cont, onClick: (){}),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children:[
                  Expanded(
                    child: Divider(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      AppText.or,
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            GestureDetector(
              onTap: (){

              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: AppShadow.textFieldShadow,
                    border: Border.all(
                        width: 2,
                        color: AppColors.greyColor
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/ic_google.svg'),
                      const SizedBox(width: 10,),
                      Text(
                        AppText.continueWithGoogle,
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            

          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
          surfaceTintColor: Colors.transparent,
          height: 95,
          child: CommonButton(title: AppText.register, onClick: (){})
        )
    );
  }
}
