import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_toast.dart';
import 'package:oqu_way/data/repository/analyze_repository/analyze_repository.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/specilaization_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../data/repository/ent_test_repository/ent_test_repository.dart';
import '../../../../domain/specialization.dart';
import '../../../../domain/subject.dart';
import '../../../common/widgets/common_button.dart';
import '../../test_screen/widgets/subject_picker_drop_down.dart';
import '../widgets/specialization_dropdown.dart';

class ProfileAnalysis extends StatefulWidget {
  const ProfileAnalysis({super.key});

  @override
  State<ProfileAnalysis> createState() => _ProfileAnalysisState();
}

class _ProfileAnalysisState extends State<ProfileAnalysis> {

  bool selected = false;
  double  sliderValue = 0;

  Specialization? selectedSpec;
  Specialization? selectedSpec2;
  Specialization? selectedSpec3;
  Specialization? selectedSpec4;

  List<String> valuesWithExtra = ['Предмет','Предмет2','Предмет3','Предмет4','Предмет5','Предмет6','Предмет7','Предмет8','Предмет9','Предмет10','Предмет11','Предмет12',];

  Subject? selectedFirst;
  Subject? selectedSecond;

  List<Subject> firstList = [];
  List<Subject> secondList = [];

  @override
  void initState() {
    getFistSubjects();
    super.initState();
  }

  Future<void> getFistSubjects() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Subject> values = await EntTestRepository().getAllEntSubjects(token!);
    setState(() {
      firstList = values;
    });
  }

  Future<void> getSecondSubjects(int id) async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Subject> values = await EntTestRepository().getAllEntSubjectsByFirst(token!, id);
    setState(() {
      secondList = values;
    });
  }

  bool dataWasSet = false;


  List<Specialization> specializations= [];

  Future<void> getSpecialization() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Specialization> values = await AnalyzeRepository().getSpecialisations(token!,[selectedFirst!.id,selectedSecond!.id]);
    setState(() {
      specializations = values;
    });
  }


  Future<void> getResult() async {
    String? token = await SharedPreferencesOperator.getAccessToken();

    List<Specialization> values = await AnalyzeRepository().getAnalyzeResult(token!,[selectedSpec!.id,selectedSpec2!.id, selectedSpec3!.id, selectedSpec4!.id], sliderValue.round());

    context.push('/profileAnalysis/profileAnalysisResult', extra: {'listOfSpecialization': values});

  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: !dataWasSet ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              
              Text(AppText.selectSubjects,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            
              const SizedBox(height: 20,),
            
              SubjectPickerDropDown(
                valuesWithExtra: firstList,
            
                onValueSelected: (Subject value) {
            
                  setState(() {
                    selectedSecond = null;
                    selectedFirst = value;
                  });
            
                  getSecondSubjects(value.id);
            
                },
                hint: AppText.firstSubject,
              ),
            
              const SizedBox(height: 10,),
            
              IgnorePointer(
                ignoring: selectedFirst == null,
                child: SubjectPickerDropDown(
                  valuesWithExtra: secondList,
                  onValueSelected: (Subject value) {
                    selectedSecond = value;
                  },
                  hint: AppText.secondSubject,
                ),
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
                      height: isTablet? 25: 16,
                      width: isTablet? 25:16,
                      padding: EdgeInsets.all(isTablet? 3:1),
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
              
              CommonButton(title: 'Келесі', onClick: (){

                if(selectedFirst!= null && selectedSecond != null){

                  getSpecialization();

                  setState(() {
                    dataWasSet = true;
                  });
                }else{
                  AppToast.showToast('Пәндерді таңданыз');
                }


              })

            ],
          ): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextButton(onPressed: (){
                setState(() {
                  selectedFirst = null;
                  selectedSecond = null;
                  sliderValue = 0;
                  dataWasSet = false;
                });
              }, child: const Text('< Пәндерді таңдау')),
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
                      valuesWithExtra: specializations,
                      onValueSelected: (Specialization? value) {
                        selectedSpec = value;
                      },
                    ),

                    Divider(color: AppColors.greyColor,),

                    SpecializationDropDown(
                      title: '2',
                      valuesWithExtra: specializations,
                      onValueSelected: (Specialization? value) {
                        selectedSpec2 = value;
                      },
                    ),
                    Divider(color: AppColors.greyColor,),
                    SpecializationDropDown(
                      title: '3',
                      valuesWithExtra: specializations,
                      onValueSelected: (Specialization? value) {
                        selectedSpec3 = value;
                      },
                    ),

                    Divider(color: AppColors.greyColor,),

                    SpecializationDropDown(
                      title: '4',
                      valuesWithExtra: specializations,
                      onValueSelected: (Specialization? value) {
                        selectedSpec4 = value;
                      },
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 10,),

              CommonButton(title: 'Анализ', onClick: (){
                if(selectedSpec!= null && selectedSpec2!= null && selectedSpec3!=null && selectedSpec4!= null){
                  getResult();
                }else{
                  AppToast.showToast('Мамандықты таңданыз');
                }
              })
            ],
          ),
        ),
      ),
    );

    //   Scaffold(
    //   body:
    //     bottomNavigationBar: BottomAppBar(
    //         padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
    //         surfaceTintColor: Colors.transparent,
    //         height: 95,
    //         child: CommonButton(title: 'Мүмкіндікті анықтау', onClick: (){context.push('/profilePage/profileAnalysis/profileAnalysisResult');})
    //     )
    //
    // );
  }
}
