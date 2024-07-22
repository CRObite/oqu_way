import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_toast.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_name_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/test_deadline_info_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../../domain/module.dart';
import '../../../common/card_container_decoration.dart';
import '../../../common/widgets/common_button.dart';

class SubjectNestedList extends StatefulWidget {
  const SubjectNestedList({super.key, required this.module, required this.subject, required this.onChanged, required this.context});

  final Module module;
  final String subject;
  final VoidCallback onChanged;
  final BuildContext context;

  @override
  State<SubjectNestedList> createState() => _SubjectNestedListState();
}

class _SubjectNestedListState extends State<SubjectNestedList> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SubjectCard(
                module: widget.module,
                onOpened: () {
                  setState(() {
                    widget.module.opened= !widget.module.opened;
                  });
                },
            ),
          ],
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                child: child,
              ),
            );
          },
          child: widget.module.opened ? Column(
            key: ValueKey<bool>(widget.module.opened),
            children: [
              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.module.topics.length,
                itemBuilder: (context,index){
                  return Column(
                    children: [
                      SubjectNameCard(
                        onButtonPressed: () { context.push('/courseVideos' , extra: {'description': widget.module.topics[index].description, 'file': widget.module.topics[index].video});},
                        name: widget.module.topics[index].name ?? '???',
                        description: widget.module.topics[index].description ?? '???',
                        hasButton: widget.module.topics[index].video!= null,
                      ),

                      const SizedBox(height: 17,),
                      widget.module.topics[index].appTest!= null ? TestDeadlineInfoCard(
                        isTest: true,
                        deadline: widget.module.topics[index].appTest!.deadline ?? '',
                        onPressed: () async {
                          if(widget.module.topics[index].appTest!.status == 'PASSED'){
                            context.push('/testPassingPage/courseTestResult', extra: {'appTestId': widget.module.topics[index].appTest!.id});
                          }else{
                            var value = await context.push('/courseTestPage', extra: {'subjectName': widget.subject, 'testId': widget.module.topics[index].appTest!.id, 'context': widget.context});
                            if(value!= null){
                              widget.onChanged();
                            }
                          }
                        },
                        isActive: widget.module.topics[index].appTest!.status != 'PASSED', description: widget.module.topics[index].appTest!.description ?? '',
                      ): const SizedBox(),
                      const SizedBox(height: 6,),
                      widget.module.topics[index].task!= null ? TestDeadlineInfoCard(
                        isTest: false,
                        deadline: widget.module.topics[index].task!.deadline ?? '',
                        onPressed: () async {
                          if(widget.module.topics[index].task!.status == 'CHECKED'){
                            context.push('/courseHomework/courseHomeworkScore', extra: {'taskId': widget.module.topics[index].task!.id});
                          }else if(widget.module.topics[index].task!.status == 'ANSWERED'){
                            AppToast.showToast('Cіздің жұмысыңыз тексеруде');
                          }else{
                            var value = await context.push('/courseHomework', extra:{'taskId':widget.module.topics[index].task!.id, 'context': widget.context});
                            if(value!= null){
                              widget.onChanged();
                            }
                          }
                        },
                        isActive: widget.module.topics[index].task!.status != 'CHECKED' && widget.module.topics[index].task!.status != 'ANSWERED',
                        description:  widget.module.topics[index].task!.description ?? '',
                      ): const SizedBox(),
                      const SizedBox(height: 26),



                    ],
                  );
                }
              ),
            ],
          ) : const SizedBox(key: ValueKey<bool>(false)),
        ),





      ],
    );
  }
}
