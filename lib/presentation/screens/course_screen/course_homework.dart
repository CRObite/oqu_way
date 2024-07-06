
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/widgets/date_time_row.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_text.dart';

class CourseHomework extends StatefulWidget {
  const CourseHomework({super.key});

  @override
  State<CourseHomework> createState() => _CourseHomeworkState();
}

class _CourseHomeworkState extends State<CourseHomework> {

  TextEditingController controller = TextEditingController();
  List<String> titles = [];
  bool isSent = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          toolbarHeight: 70,
          leading: GestureDetector(
              onTap: (){
                context.pop();
              },
              child: const Icon(Icons.arrow_back_ios_new_rounded,size: 18, )
          ),
          title: Text(AppText.homeworks, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Тапсырма уақыты',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9,horizontal: 11),
                        child: DateTimeRow(color: AppColors.greenColor,)
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15,),

                Text('Тақырыбы', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                const Text('Арифметикалық прогрессияға есептер',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                const SizedBox(height: 15,),

                Text('Мұғалім', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                const Text('Harsh Kadyan',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),

                const SizedBox(height: 15,),

                Text('Тапсырма сипаттамасы', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                const Text('Lorem ipsum dolor sit amet consectetur adipiscing elit Ut et massa mi. Aliquam in hendrerit urna. Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet. Pellentesque commodo lacus at sodales sodales. Quisque sagittis orci ut diam condimentum, vel euismod erat placerat. In iaculis arcu eros, eget tempus orci facilisis id. Praesent lorem orci, mattis non efficitur id, ultricies vel nibh. Sed volutpat lacus vitae gravida ',
                  style: TextStyle(fontSize: 13),),

                const SizedBox(height: 15,),

                Text('Материалдар', style: TextStyle(color: AppColors.greyColor,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 3,
                    ),
                    itemCount: 9,
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

                const Text('Тапсыру',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                const SizedBox(height: 15,),

                const Text('Тапсырмаға түсіндірме жазып файлды жүктеңіз',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),

                const SizedBox(height: 10,),

                Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          width: 1,
                          color: AppColors.greyColor
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: TextFormField(
                      controller: controller,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Хабарлама қалдырыңыз...',
                      ),
                    )
                ),

                const SizedBox(height: 15,),

                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 3,
                    ),
                    itemCount: titles.length,
                    itemBuilder: (context,index){
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColors.greyColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Center(
                                  child: Text(titles[index], style: const TextStyle(fontSize: 10,overflow: TextOverflow.ellipsis,),maxLines: 1,)
                              ),
                            ),

                            isSent ?const SizedBox(): Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap:(){
                                  setState(() {
                                    titles.removeAt(index);
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 2, right: 2),
                                  height: 15,
                                  width: 15,
                                  decoration:  BoxDecoration(
                                      color: Colors.grey.shade600,
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.close,color: Colors.white,size: 10,),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                ),
                isSent ?const SizedBox(): const SizedBox(height: 15,),

                isSent ?const SizedBox(): GestureDetector(
                  onTap: (){
                    setState(() {
                      titles.add('newFile.png');
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          width: 1,
                          color: AppColors.greyColor
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 50),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Файл жүктеңіз',style: TextStyle(fontSize: 10),),
                        SizedBox(width: 5,),
                        Icon(Icons.upload,size: 14,),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15,),


                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSent = !isSent;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: isSent ? Colors.orange.withOpacity(0.2): AppColors.greyColor.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 22),
                    child: Text( isSent ? 'Өзгерту': 'Жіберу',
                      style: TextStyle(color: AppColors.greenColor,fontSize: 10),
                    )
                  ),
                ),

                const SizedBox(height: 10,),

                isSent ? GestureDetector(
                  onTap: (){context.push('/courseHomework/courseHomeworkScore');},
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.blueColor.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 22),
                      child: Text('Бағаны көру',
                        style: TextStyle(color: AppColors.blueColor,fontSize: 10),
                      )
                  ),
                ): const SizedBox(),

              ],
            ),
          ),
        ),
    );
  }
}
