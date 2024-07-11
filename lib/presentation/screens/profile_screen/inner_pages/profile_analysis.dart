import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../test_screen/widgets/subject_picker_drop_down.dart';
import '../widgets/specialization_dropdown.dart';

class ProfileAnalysis extends StatefulWidget {
  const ProfileAnalysis({super.key});

  @override
  State<ProfileAnalysis> createState() => _ProfileAnalysisState();
}

class _ProfileAnalysisState extends State<ProfileAnalysis> {

  String selectedFirst = '';
  String selectedSecond = '';
  bool selected = false;
  double  sliderValue = 0;


  String selectedSpec = '';
  String selectedSpec2 = '';
  String selectedSpec3 = '';
  String selectedSpec4 = '';


  List<String> valuesWithExtra = ['Предмет','Предмет2','Предмет3','Предмет4','Предмет5','Предмет6','Предмет7','Предмет8','Предмет9','Предмет10','Предмет11','Предмет12',];

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
        title: Text(AppText.analysis, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.selectSubjects,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

              const SizedBox(height: 20,),

              SubjectPickerDropDown(
                valuesWithExtra: valuesWithExtra,
                selectedValue: selectedFirst,
                onValueSelected: (String value) {
                  selectedFirst = value;
                },
                hint: AppText.firstSubject,
              ),

              const SizedBox(height: 10,),

              SubjectPickerDropDown(
                valuesWithExtra: valuesWithExtra,
                selectedValue: selectedSecond,
                onValueSelected: (String value) {
                  selectedSecond = value;
                },
                hint: AppText.secondSubject,
              ),

              const SizedBox(height: 10,),

              GestureDetector(
                onTap:  (){
                  setState(() {
                    selected = !selected;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1,color:
                        selected ? AppColors.blueColor.withOpacity(0.5) :
                        AppColors.greyColor
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selected ? AppColors.blueColor:Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text(AppText.villageQuota)
                  ],
                ),
              ),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Сенің ҰБТ - дан алған баллың', style: TextStyle(fontSize: 16),),
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

              const SizedBox(height: 10,),
              Text(AppText.selectSpecialization,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: AppShadow.shadow),
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [

                    SpecializationDropDown(
                      title: '1',
                      valuesWithExtra: valuesWithExtra,
                      selectedValue: selectedSpec,
                      onValueSelected: (String value) {
                        selectedSpec = value;
                      },
                    ),

                    Divider(color: AppColors.greyColor,),

                    SpecializationDropDown(
                      title: '2',
                      valuesWithExtra: valuesWithExtra,
                      selectedValue: selectedSpec2,
                      onValueSelected: (String value) {
                        selectedSpec2 = value;
                      },
                    ),
                    Divider(color: AppColors.greyColor,),
                    SpecializationDropDown(
                      title: '3',
                      valuesWithExtra: valuesWithExtra,
                      selectedValue: selectedSpec3,
                      onValueSelected: (String value) {
                        selectedSpec3 = value;
                      },
                    ),

                    Divider(color: AppColors.greyColor,),

                    SpecializationDropDown(
                      title: '4',
                      valuesWithExtra: valuesWithExtra,
                      selectedValue: selectedSpec4,
                      onValueSelected: (String value) {
                        selectedSpec4 = value;
                      },
                    ),


                  ],
                ),
              )

            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: CommonButton(title: 'Мүмкіндікті анықтау', onClick: (){context.push('/profilePage/profileAnalysis/profileAnalysisResult');})
        )

    );
  }
}
