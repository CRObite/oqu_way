import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';

import '../../config/app_shadow.dart';
import '../../data/repository/auth_reg_repository/authorization_repository.dart';
import '../../util/custom_exeption.dart';
import '../../util/google_sign_in_api.dart';
import '../common/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String validation = '';


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      bool value = await AuthorizationRepository().login(
          emailController.text,
          passwordController.text
      );

      if (value) {
        context.go('/news');
      }
    } catch (error) {
      if (error is DioException) {
        CustomException.fromDioException(error);

        setState(() {
          validation = error.response?.data['detail'] ?? {};
        });

      }else{
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                onPressed: (){context.goNamed('passwordRecovery');},
                child: Text(AppText.forgotPassword, style: TextStyle(fontSize: 10, color: AppColors.blueColor),)
            ),
            validation.isNotEmpty ? Text(validation, style: const TextStyle(color: Colors.red),):const SizedBox(),
            const SizedBox(height: 20,),
            CommonButton(title: AppText.cont, onClick: (){
              login();
            }),
            const SizedBox(height: 20,),
            

          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
          surfaceTintColor: Colors.transparent,
          height: 95,
          child: CommonButton(title: AppText.register, onClick: (){context.go('/registrationPage');})
        )
    );
  }
}
