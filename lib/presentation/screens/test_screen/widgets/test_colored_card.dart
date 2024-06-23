import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';

class TestColoredCard extends StatelessWidget {
  const TestColoredCard({super.key, required this.index});

  final int index;

  String getImage(int index){
    List<String> image = ['assets/image/lamp.png', 'assets/image/chart.png', 'assets/image/flower.png'];
    return image[index % image.length];
  }

  Color getColor(int index){
    List<Color> colors = [AppColors.testCardColor1,AppColors.testCardColor2,AppColors.testCardColor3,];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 110,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: getColor(index),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Кәсіби', style: TextStyle(color: Colors.white, fontSize: 5)),
              SizedBox(height: 12),
              Text('Профориентация', maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 8)),
              SizedBox(height: 7),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
                height: 60,
                child: Image.asset(getImage(index), fit: BoxFit.fitHeight)
            ),
          ),
        ],
      ),
    );
  }
}
