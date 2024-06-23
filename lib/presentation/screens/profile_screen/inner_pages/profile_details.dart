import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/lower_text_field.dart';

import '../../../common/widgets/common_button.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: Text(AppText.profile, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(

          children: [
            LowerTextFiled(title: AppText.name, controller: nameController, type: TextInputType.text),
            LowerTextFiled(title: AppText.surname, controller: surnameController, type: TextInputType.text),
            LowerTextFiled(title: AppText.lastname, controller: lastnameController, type: TextInputType.text),
            LowerTextFiled(title: AppText.telephone, controller: telephoneController, type: TextInputType.phone),
            LowerTextFiled(title: AppText.email, controller: emailController, type: TextInputType.emailAddress),

          ],
        ),
      ),

        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: CommonButton(title: AppText.save, onClick: (){context.pop();})
        )
    );
  }
}
