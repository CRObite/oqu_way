import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';

import '../../config/app_shadow.dart';
import '../../util/google_sign_in_api.dart';
import '../common/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
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
            CustomTextField(title: AppText.enterPhone, controller: phoneController, type: TextInputType.phone, hint:AppText.number,),
            const SizedBox(height: 20,),
            CustomTextField(title:  AppText.enterPassword , controller: passwordController, type: TextInputType.visiblePassword, hint:AppText.password),
            TextButton(
                onPressed: (){context.goNamed('passwordRecovery');},
                child: Text(AppText.forgotPassword, style: TextStyle(fontSize: 10, color: AppColors.blueColor),)
            ),
            const SizedBox(height: 20,),
            CommonButton(title: AppText.cont, onClick: (){context.go('/news');}),
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
