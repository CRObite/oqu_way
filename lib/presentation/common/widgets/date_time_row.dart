import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateTimeRow extends StatelessWidget {
  const DateTimeRow({super.key, this.color = Colors.black});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/icons/ic_calendar.svg',
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
          height: 15,
        ),
        const SizedBox(width: 9,),
        Text('12.01.2023', style: TextStyle(fontSize: 12, color: color,fontWeight: FontWeight.bold)),
        const SizedBox(width: 12,),
        SvgPicture.asset(
          'assets/icons/ic_time.svg',
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
          height: 15,
        ),
        const SizedBox(width: 9,),
        Text('12:00', style: TextStyle(fontSize: 12,color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
