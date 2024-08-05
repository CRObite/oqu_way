import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/test_repository/test_repository.dart';
import 'package:oqu_way/domain/app_test.dart';
import 'package:oqu_way/presentation/common/info_border_row.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../test_screen/widgets/subject_picker_drop_down.dart';

class CourseTestPage extends StatefulWidget {
  const CourseTestPage({super.key, required this.subjectName, required this.testId, this.context});

  final String subjectName;
  final int? testId;
  final BuildContext? context;

  @override
  State<CourseTestPage> createState() => _CourseTestPageState();
}

class _CourseTestPageState extends State<CourseTestPage> {

  AppTest? test;

  bool isLoading = true;

  @override
  void initState() {
    getTestById();
    super.initState();
  }


  Future<void> getTestById() async {
    setState(() {
      isLoading = true;
    });

    String? token = await SharedPreferencesOperator.getAccessToken();

    AppTest? value = await TestRepository().getTestById(token!, widget.testId!);

    setState(() {
      test = value;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;
    bool isSmall = MediaQuery.of(context).size.width <= 360;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: Text('${widget.subjectName} > Тест', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.blueColor,),) : Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 138,
                height: 138,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.testCircleGreenColor,
                  shape: BoxShape.circle,
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset('assets/image/chart.png'),
                ),
              ),
              const SizedBox(height: 20,),

              InfoBorderRow(label: 'Пән', value: widget.subjectName),
              // const InfoBorderRow(label: 'Уақыт', value: '40 мин'),
              InfoBorderRow(label: 'Сұрақ саны', value: '${test!.questions!.length}'),

              isSmall? const SizedBox(): const SizedBox(height: 80,),
            ],
          ),
        ),
      ),

        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(20),
            surfaceTintColor: Colors.transparent,
            height: isTablet? 110: 95,
            color: Colors.transparent,
            child: CommonButton(title:'Тестті бастау', onClick: () async {

              if(!isLoading){
                String? token =  await SharedPreferencesOperator.getAccessToken();
                bool value = await TestRepository().startTest(token!, widget.testId!);

                if(value){
                  context.pushReplacement(
                    '/testPassingPage',
                    extra: {'oneSubjectPage': true, 'app_test': test, 'context': widget.context},);
                }
              }

              },
              fontSize: isSmall? 12: 16,
            )
        )

    );
  }
}
