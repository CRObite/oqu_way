import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_formatter.dart';
import 'package:oqu_way/data/repository/auth_reg_repository/authorization_repository.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../config/app_text.dart';
import '../common/widgets/common_button.dart';
import '../common/widgets/custom_text_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String phoneValidation = '';
  String nameValidation = '';
  String surnameValidation = '';
  String emailValidation = '';

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  void showPopUp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Тіркеу cәтті өтті'),
          content:
              const Text('Құпия сөз сіздің электрондық поштаңызға жіберілді'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.go('/loginPage');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> registration() async {
    try {


      bool value = await AuthorizationRepository().registration(

          emailController.text,
          AppFormatter.formatPhoneNumber(phoneController.text),
          nameController.text,
          surnameController.text,
          middleNameController.text
      );

      if (value) {
        showPopUp();
      }
    } catch (error) {
      if (error is DioException) {
        CustomException.fromDioException(error);

        var fieldErrors = error.response?.data['fieldErrors'] ?? {};

        setState(() {
          nameValidation = fieldErrors['firstName'] ?? '';
          surnameValidation = fieldErrors['lastName'] ?? '';
          phoneValidation = fieldErrors['phoneNumber'] ?? '';
          emailValidation = fieldErrors['email'] ?? '';

        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;

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
                            onTap: () {
                              context.go('/loginPage');
                            },
                            child: Text(
                              '< ${AppText.enter}',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.blueColor),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  AppText.welcome,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                    title: AppText.email,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    hint: AppText.email, isTabled: isTablet,),
                emailValidation.isNotEmpty ? Text(emailValidation, style: const TextStyle(color: Colors.red),):const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: AppText.name,
                  controller: nameController,
                  type: TextInputType.text,
                  hint: AppText.name,isTabled: isTablet,
                ),
                nameValidation.isNotEmpty? Text(nameValidation, style: const TextStyle(color: Colors.red),):const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: AppText.surname,
                  controller: surnameController,
                  type: TextInputType.text,
                  hint: AppText.surname,isTabled: isTablet,
                ),
                surnameValidation.isNotEmpty? Text(surnameValidation, style: const TextStyle(color: Colors.red),):const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  title: AppText.lastname,
                  controller: middleNameController,
                  type: TextInputType.text,
                  hint: AppText.lastname,isTabled: isTablet,
                ),
                const SizedBox(
                  height: 20,
                ),


                CustomTextField(
                  title: AppText.enterPhone,
                  controller: phoneController,
                  type: TextInputType.phone,
                  hint: AppText.number,isTabled: isTablet,
                ),
                phoneValidation.isNotEmpty? Text(phoneValidation, style: const TextStyle(color: Colors.red),):const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            height: isTablet ? 110: 95,
            child: CommonButton(
                title: AppText.register,
                onClick: () {
                  registration();
                })));
  }
}
