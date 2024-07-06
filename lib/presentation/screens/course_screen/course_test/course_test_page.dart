import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/info_border_row.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/common_button.dart';
import '../../test_screen/widgets/subject_picker_drop_down.dart';

class CourseTestPage extends StatefulWidget {
  const CourseTestPage({super.key});

  @override
  State<CourseTestPage> createState() => _CourseTestPageState();
}

class _CourseTestPageState extends State<CourseTestPage> {


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
        title: const Text('Математика > Тест', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body:Padding(
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

              const InfoBorderRow(label: 'Пән', value: 'Тарих'),
              const InfoBorderRow(label: 'Уақыт', value: '40 мин'),
              const InfoBorderRow(label: 'Сұрақ саны', value: '40'),

              const SizedBox(height: 80,),
            ],
          ),
        ),
      ),

        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.only(left: 20,right: 20, bottom: 42),
            surfaceTintColor: Colors.transparent,
            height: 95,
            child: CommonButton(title:'Тестті бастау', onClick: (){
              context.push(
                '/testPassingPage',
                extra: {'oneSubjectPage': true},);
            }, )
        )

    );
  }
}
