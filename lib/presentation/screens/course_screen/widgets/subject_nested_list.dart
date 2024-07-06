import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_name_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/test_deadline_info_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../common/card_container_decoration.dart';
import '../../../common/widgets/common_button.dart';

class SubjectNestedList extends StatefulWidget {
  const SubjectNestedList({super.key, required this.opened, required this.openedPressed});

  final bool opened;
  final VoidCallback openedPressed;


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
                opened: widget.opened,
                openedChanged: (){
                  widget.openedPressed();
                }
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
          child: widget.opened ? Column(
            key: ValueKey<bool>(widget.opened),
            children: [
              const SizedBox(height: 20),
              SubjectNameCard(buttonName: AppText.video, withDate: false, onButtonPressed: () { context.goNamed('courseVideos');},),
              const SizedBox(height: 17,),
              TestDeadlineInfoCard(isTest: true, onPressed: () { context.push('/courseTestPage');},),
              const SizedBox(height: 6,),
              TestDeadlineInfoCard(isTest: false, onPressed: () {context.push('/courseHomework');},),
              const SizedBox(height: 26),
            ],
          ) : const SizedBox(key: ValueKey<bool>(false)),
        ),





      ],
    );
  }
}
