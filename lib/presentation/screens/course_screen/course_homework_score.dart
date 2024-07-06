import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';
import '../../common/widgets/date_time_row.dart';
import '../../common/widgets/rounded_circular_progress_indicator.dart';

class CourseHomeworkScore extends StatefulWidget {
  const CourseHomeworkScore({super.key});

  @override
  State<CourseHomeworkScore> createState() => _CourseHomeworkScoreState();
}

class _CourseHomeworkScoreState extends State<CourseHomeworkScore> with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  List<String> titles = [];
  bool isSent = false;



  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0.7).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 70,
        leading: GestureDetector(
            onTap: (){
              context.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
        ),
        title: const Text('Тапсырмалар > Бағалар', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20 ,right: 20,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('Тапсырма бағасы', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 75,
                        width: 75,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CustomPaint(
                                size: const Size(75, 75),
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
                                '121',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),

                    Text('60/100',style: TextStyle(fontSize: 13, color: AppColors.greyColor,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 40,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Тапсырмаға берілген coins : 2 coins', style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        Text('Материалдар', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                        const SizedBox(height: 20,),

                        GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 3,
                            ),
                            itemCount: 3,
                            itemBuilder: (context,index){
                              return Container(
                                decoration: BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(5))
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Center(child: Text('assigment.$index.pdf', style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,),maxLines: 1,)),
                              );
                            }
                        ),

                        const SizedBox(height: 20,),
                        Text('Мұғалімнің пікірі', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                        const SizedBox(height: 20,),

                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                          ),
                          padding: const EdgeInsets.all(10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context,index){
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: AppColors.greyColor.withOpacity(0.3),
                                          shape: BoxShape.circle
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'A',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 10,),

                                      Expanded(
                                        child: Container(
                                          height: 100,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Text('Әлі де дайындалу керек!',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20,),

            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: Border.all(
                          width: 1,
                          color: AppColors.greyColor.withOpacity(0.5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 10),
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Жауап жазу...',
                            hintStyle: TextStyle(color: AppColors.greyColor.withOpacity(0.5)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
