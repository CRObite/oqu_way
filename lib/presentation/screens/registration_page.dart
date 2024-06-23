import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../config/app_text.dart';
import '../common/widgets/common_button.dart';
import '../common/widgets/custom_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: (){
                              context.go('/loginPage');
                            },
                            child: Text(
                              '< ${AppText.enter}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.blueColor),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  AppText.welcome,
                  style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32,),
                CustomTextField(
                    title:  AppText.name,
                    controller: nameController,
                    type: TextInputType.text,
                    hint: AppText.name,
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  title:  AppText.surname,
                  controller: surnameController,
                  type: TextInputType.text,
                  hint: AppText.surname,
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  title: AppText.enterEmail,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  hint:AppText.email,),
                const SizedBox(height: 20,),
                CustomTextField(
                    title:  AppText.enterPassword ,
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    hint:AppText.password),
                const SizedBox(height: 20,),
                CustomTextField(
                    title:  AppText.enterPasswordAgain ,
                    controller: confirmPasswordController,
                    type: TextInputType.visiblePassword,
                    hint:AppText.password
                ),
                const SizedBox(height: 20,),


              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: CommonButton(title: AppText.register, onClick: (){context.go('/loginPage');})
        )
    );
  }
}
