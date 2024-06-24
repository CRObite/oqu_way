import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../common/widgets/rounded_circular_progress_indicator.dart';

class ProfileAttends extends StatefulWidget {
  const ProfileAttends({super.key});

  @override
  State<ProfileAttends> createState() => _ProfileAttendsState();
}

class _ProfileAttendsState extends State<ProfileAttends> with SingleTickerProviderStateMixin {
  List<int> chartData = [];
  int current = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    generateRandomData();


    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0.7).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void generateRandomData() {
    final random = Random();
    chartData.clear();
    for (int i = 0; i < 12; i++) {
      chartData.add(random.nextInt(140));
    }
  }

  Widget getBottomTitles( double value , TitleMeta meta){

    TextStyle style = TextStyle(
      color: AppColors.greyColor,
      fontSize: 7,
      fontWeight: FontWeight.bold
    );

    return SideTitleWidget(axisSide: meta.axisSide, child: Text('${(value.toInt()) + 1}/12',style: style));
  }

  Widget getLeftTitles( double value , TitleMeta meta){

    TextStyle style = TextStyle(
        color: AppColors.greyColor,
        fontSize: 10,
        fontWeight: FontWeight.bold
    );

    return SideTitleWidget(axisSide: meta.axisSide, child: Text('${value.toInt()}',style: style));
  }

  Color getColorForValue(int value) {
    if (value >= 0 && value < 50) {
      return AppColors.blueColor;
    } else if (value >= 50 && value < 100) {
      return AppColors.chartYellowColor;
    } else if (value >= 100 && value <= 140) {
      return AppColors.chartGreenColor;
    } else {
      return Colors.grey;
    }
  }

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
        title: Text(AppText.attends, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.myAttend,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

              const SizedBox(height: 20,),

              Text(AppText.scoreChart,style: const TextStyle(fontSize: 12),),
              const SizedBox(height: 10,),

              Container(
                decoration: CardContainerDecoration.decoration,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl(
                        onValueChanged: (value) {
                          if(value != null){
                            setState(() {
                              current = value;
                              generateRandomData();

                            });
                          }
                        },
                        children: {
                          0:Text(AppText.perWeek, style: const TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                          1:Text(AppText.perMonth, style: const TextStyle(fontSize: 8,fontWeight: FontWeight.bold)),
                          2:Text(AppText.perYear, style: const TextStyle(fontSize: 8,fontWeight: FontWeight.bold)),
                        },
                        groupValue: current,

                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),


                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 140,
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipRoundedRadius: 5,
                                tooltipMargin: 5,
                                getTooltipColor: (
                                    BarChartGroupData group,
                                ){
                                  return const Color(0xFF85A3BB);
                                },
                                getTooltipItem: (
                                  BarChartGroupData group,
                                  int groupIndex,
                                  BarChartRodData rod,
                                  int rodIndex,
                                ){
                                  const textStyle = TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:8
                                  );
                                  return BarTooltipItem((rod.toY).toInt().toString(), textStyle);
                                },
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              horizontalInterval: 20.0,
                              verticalInterval: 0.0834,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: AppColors.greyColor.withOpacity(0.5),
                                  strokeWidth: 1,
                                );
                              },
                              drawVerticalLine: true,
                              drawHorizontalLine: true,
                              getDrawingVerticalLine: (value) {
                                return FlLine(
                                  color: AppColors.greyColor.withOpacity(0.5),
                                  strokeWidth: 1,
                                );
                              },

                            ),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 26,
                                  getTitlesWidget: getBottomTitles
                                ),
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval:20,
                                  reservedSize: 30,
                                  getTitlesWidget: getLeftTitles
                                )
                              )
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                bottom: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                                left: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                                top:BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                                right:BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                              )
                            ),
                            barGroups: List.generate(
                              chartData.length,
                                  (index) => BarChartGroupData(
                                x: index,
                                barsSpace: 10,
                                barRods: [
                                  BarChartRodData(
                                    color: getColorForValue(chartData[index]),
                                    width: 16,
                                    borderRadius: const BorderRadius.only(
                                       topLeft: Radius.circular(3),
                                      topRight: Radius.circular(3),
                                    ),
                                    toY: chartData[index].toDouble(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10,),

              Text(AppText.scoresBySubject,style: const TextStyle(fontSize: 12),),
              const SizedBox(height: 10,),

              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: 5,
                  itemBuilder: (context,index){
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Математика',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 14,),

                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomPaint(
                                    size: const Size(80, 80),
                                    painter: RoundedCircularProgressIndicator(
                                      value: _animation.value,
                                      color: AppColors.greenColor,
                                      strokeWidth: 10,
                                      backgroundColor: AppColors.greyColor.withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                    '98',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30,),

                          Row(
                            children: [
                              Container(
                                height: 21,
                                width: 21,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.play_arrow, color: Colors.white,size: 6,),
                                ),
                              ),

                             const SizedBox(width: 5,),
                              const Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Бүгінгі баға',
                                      style: TextStyle(fontSize: 10),
                                    ),

                                    Text(
                                      '98/100',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),






                            ],
                          )

                        ],
                      ),
                    );
                  }
              )

            ],
          ),
        ),
      ),

    );
  }
}
