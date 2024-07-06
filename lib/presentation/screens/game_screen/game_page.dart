
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';
import 'package:oqu_way/presentation/common/widgets/common_button.dart';
import 'package:oqu_way/presentation/screens/test_screen/widgets/subject_picker_drop_down.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../config/app_text.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {



  String selectedValue = '';

  List<String> valuesWithExtra = ['Предмет','Предмет2','Предмет3','Предмет4','Предмет5','Предмет6','Предмет7','Предмет8','Предмет9','Предмет10','Предмет11','Предмет12',];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            boxShadow: AppShadow.shadow,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: [
              Transform.scale(
                scale: 1.2,
                child: SvgPicture.asset(
                  'assets/icons/decoration.svg',
                  fit: BoxFit.contain,
                ),
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                            color: AppColors.greenColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7,),
                    const Text('Алуа Алпысбаева', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),)
                  ],
                ),
              )
            ],
          ),
        ),

        const SizedBox(height: 20,),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SubjectPickerDropDown(
                  valuesWithExtra: valuesWithExtra,
                  selectedValue: selectedValue,
                  onValueSelected: (value){
                    selectedValue = value;
                  },
                  hint: 'Пән таңдаңыз'
              ),

              const SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor:AppColors.blueColor,
                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 20),
                ),
                onPressed: (){context.push('/gameFriendList');},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Досымды шақыру', style: TextStyle(color: Colors.white, fontSize: 16),),
                    SvgPicture.asset('assets/icons/ic_find_persone.svg')
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              CommonButton(title: 'Ойынды бастау', onClick: (){context.push('/gameStartScreen');}),
              const SizedBox(height: 40,),
              const Text(
                'Соңғы ойындар',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),

              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: AppShadow.shadow
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration:  BoxDecoration(
                                    color: AppColors.greyColor.withOpacity(0.5),
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'B',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10,),


                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Бекзат Орынжай',style: TextStyle(fontSize: 15,),),
                                    Text('Пән: Физика',style: TextStyle(fontSize: 10,),),
                                  ],
                                )

                              ],
                            ),
                          ),


                          Container(
                            height: 60,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                          )
                        ],

                      ),
                    );
                  }
              ),

              const SizedBox(height: 80,),
            ],
          ),
        ),





      ],
    );
  }
}
