import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../config/app_text.dart';

class ProfileSchedule extends StatefulWidget {
  const ProfileSchedule({super.key});

  @override
  State<ProfileSchedule> createState() => _ProfileScheduleState();
}

class _ProfileScheduleState extends State<ProfileSchedule> {
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
        title: Text(AppText.schedule, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: SfCalendar(
        view: CalendarView.week,

      ),
    );
  }
}
