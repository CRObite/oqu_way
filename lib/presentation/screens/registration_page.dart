import 'package:flutter/material.dart';

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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
