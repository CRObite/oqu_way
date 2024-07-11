import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/lower_text_field.dart';

import '../../../common/widgets/common_button.dart';
import '../widgets/specialization_dropdown.dart';

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

  String selected = '';
  List<String> valuesWithExtra = ['12 сынып','11 сынып','10 сынып','9 сынып',];
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Категория',style: TextStyle(fontSize: 11,color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DropdownButton2<String>(
                      value: selected.isNotEmpty ? selected : null,
                      onChanged: (String? newValue) {
                        if(newValue!= null){
                          setState(() {
                            selected = newValue;
                          });
                        }
                      },
                      items: valuesWithExtra.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      iconStyleData: IconStyleData(
                          icon: Transform.rotate(
                            angle: 90 * 3.1415926535/180,
                            child: SvgPicture.asset(
                              'assets/icons/ic_arrow.svg',
                              height: 11,
                              width: 5,
                            ),
                          )
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: MediaQuery.of(context).size.width - 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: WidgetStateProperty.all(6),
                          thumbVisibility: WidgetStateProperty.all(true),
                        ),
                      ),
                      isExpanded: true,
                      underline: Container(),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),

                  Container(width: double.infinity,height: 1,color: AppColors.greyColor,)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Пробный тесттен алған балл', style: TextStyle(fontSize: 16),),
                Text('${sliderValue.round()}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            ),

            Slider(
                value: sliderValue,
                min: 0,
                max: 140,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
                activeColor: AppColors.blueColor,
                inactiveColor:AppColors.greyColor.withOpacity(0.5)
            ),
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
