import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/data/local/shared_preferences_operator.dart';
import 'package:oqu_way/data/repository/test_repository/test_repository.dart';
import 'package:oqu_way/domain/test_result.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../../common/info_border_row.dart';
import '../../../common/widgets/common_button.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';
import '../course_details_cubit/course_details_cubit.dart';

class CourseTestResult extends StatefulWidget {
  const CourseTestResult({super.key, required this.appTestId, required this.onClose, this.context});

  final int? appTestId;
  final VoidCallback onClose;
  final BuildContext? context;

  @override
  State<CourseTestResult> createState() => _CourseTestResultState();
}

class _CourseTestResultState extends State<CourseTestResult> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  TestResult? result;

  Future<void> getResults() async {
    try{
      String? token = await SharedPreferencesOperator.getAccessToken();
      // String? user = await SharedPreferencesOperator.getCurrentUser();
      //
      // AppUser us = AppUser.fromJson(jsonDecode(user!));

      TestResult? value = await TestRepository().getTestResult(token!, widget.appTestId!);

      setState(() {
        result = value;
        _controller = AnimationController(
          duration: const Duration(seconds: 1),
          vsync: this,
        );
        _animation = Tween<double>(begin: 0, end: result!.percentage!= null ? result!.percentage! / 100 : 0.0).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
        _controller.forward();
      });
    }catch(error){

      print(error);
      if(error is DioException){
        CustomException.fromDioException(error);
      }

    }
  }

  @override
  void initState() {
    super.initState();
    getResults();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;
    bool isSmall = MediaQuery.of(context).size.width <= 360;


    return Scaffold(
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: result == null
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
            height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CustomPaint(
                              size: const Size(120, 120),
                              painter: RoundedCircularProgressIndicator(
                                value: _animation.value,
                                color: AppColors.greenColor,
                                strokeWidth: 15,
                                backgroundColor: AppColors.greyColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${result!.userScore ?? 0}',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InfoBorderRow(label: 'Сұрақ саны', value: '${result!.totalScore ?? 0}'),
                  InfoBorderRow(label: 'Ұпай саны', value: '${result!.userScore ?? 0}'),
                  InfoBorderRow(label: 'Процент', value: '${result!.percentage ?? 0}'),
                  const SizedBox(height: 80),
                ],
              ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
        surfaceTintColor: Colors.transparent,
        color: Colors.transparent,
        height: isSmall? 85: isTablet? 150: 100,
        child: Column(
          children: [
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.blueColor.withOpacity(0.2),
            //       elevation: 0,
            //       side: BorderSide(
            //         color: AppColors.blueColor,
            //         width: 1,
            //       ),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5),
            //       ),
            //       padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 27),
            //     ),
            //     onPressed: () {
            //       context.push('/testResults/testMistakeWork');
            //     },
            //     child: Text(
            //       'Қатемен жұмыс',
            //       style: TextStyle(color: AppColors.blueColor, fontSize: 15),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 15),
            CommonButton(
              title: 'Шығу',
              onClick: () {
                if(widget.context!= null){
                  widget.context!.read<CourseDetailsCubit>().getCourseInfo();
                }
                context.pop();
              },
              fontSize: isSmall? 12 : 16,
            ),
          ],
        ),
      ),
    );
  }
}
