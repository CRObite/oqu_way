import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/subject_name_card.dart';
import 'package:oqu_way/presentation/screens/course_screen/widgets/test_deadline_info_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../common/card_container_decoration.dart';
import '../../../common/widgets/common_button.dart';

class SubjectNestedList extends StatefulWidget {
  const SubjectNestedList({super.key, required this.opened, required this.openedPressed, required this.isFirst});

  final bool opened;
  final VoidCallback openedPressed;
  final bool isFirst;

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

            const SizedBox(width: 17,),

            widget.isFirst ? Container(

              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: CardContainerDecoration.decoration,
              child: Column(
                children: [
                  Text(AppText.attandance, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),),
                  Text('80%', style: TextStyle(color: AppColors.greenColor),),
                ],
              ),
            ):  const SizedBox(width: 90),
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
              const SizedBox(height: 26),
              SubjectNameCard(buttonName: AppText.video, withDate: false,),
              const SizedBox(height: 5,),
              SubjectNameCard(buttonName: AppText.attend, withDate: false,),
              const SizedBox(height: 17,),
              const TestDeadlineInfoCard(),
              const SizedBox(height: 6,),
              const TestDeadlineInfoCard(),
              const SizedBox(height: 17,),
              SubjectNameCard(buttonName: AppText.attend, withDate: true,),
              const SizedBox(height: 26),
            ],
          ) : const SizedBox(key: ValueKey<bool>(false)),
        ),





      ],
    );
  }
}
