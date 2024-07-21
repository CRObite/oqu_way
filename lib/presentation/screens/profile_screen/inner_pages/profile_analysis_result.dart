import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/data/repository/university_repository/university_repository.dart';
import 'package:oqu_way/domain/pagination.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/university_card.dart';

import '../../../../config/app_text.dart';
import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../domain/specialization.dart';
import '../../../../domain/university.dart';

class ProfileAnalysisResult extends StatefulWidget {
  const ProfileAnalysisResult({super.key, required this.listOfSpecialization});

  final List<Specialization> listOfSpecialization;

  @override
  State<ProfileAnalysisResult> createState() => _ProfileAnalysisResultState();
}

class _ProfileAnalysisResultState extends State<ProfileAnalysisResult> {

  Future<List<University>> getUniversities(int specializationId) async {


    print(specializationId);
    String? token = await SharedPreferencesOperator.getAccessToken();

    Pagination? pageinit = await UniversityRepository().getAllUniversity(token!, 0, 4, null, specializationId, '');

    if(pageinit!= null){
      List<University> values = [];

      for(var item in pageinit.items){
        values.add(University.fromJson(item));
      }

      return values;
    }else{
      return [];
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: (){
                      context.pop();
                    }, child: Text('${AppText.analysis} > Ықтималдылық', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                ),
                const SizedBox(height: 20,),

                const Center(child: Text('Мемлекеттік грантқа түсу ықтималдылығы',style: TextStyle(fontWeight: FontWeight.bold),)),
                const SizedBox(height: 20,),
          
                ListView.builder(
                  itemCount: widget.listOfSpecialization.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){


                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: AppColors.greyColor
                          )
                        )
                      ),
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [

                          Text('${widget.listOfSpecialization[index].possibilityChance ?? 0}%',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          const SizedBox(height: 10,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${index+1}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              const SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.listOfSpecialization[index].name ?? '',style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                                  Text('Код : ${widget.listOfSpecialization[index].code ?? ''}',style: TextStyle(fontSize: 10,color: AppColors.greyColor),),
                                ],
                              )
                            ],
                          ),

                          FutureBuilder<List<University>>(
                            future: getUniversities(widget.listOfSpecialization[index].id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Text('');
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index2) {
                                    University university = snapshot.data![index2];
                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.push('/profileUniversityDetails', extra: {'universityId': university.id});
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    university.name ?? '???',
                                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'Мамандық саны: ${university.specializations!.length}',
                                                    style: TextStyle(fontSize: 10, color: AppColors.greyColor),
                                                  ),
                                                  Text(
                                                    '${university.city!.name} қаласы, ${university.address}',
                                                    style: TextStyle(fontSize: 10, color: AppColors.greyColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      )
          
                    );
                  }
                ),
                // const SizedBox(height: 30,),
                // const Text('80%',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                // const SizedBox(height: 10,),
                // const Center(child: Text('Мемлекеттік грантқа түсу ықтималдылығы',style: TextStyle(fontWeight: FontWeight.bold),)),
                // const SizedBox(height: 20,),
                // ListView.builder(
                //     itemCount: 4,
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemBuilder: (context,index){
                //       return Container(
                //           margin: const EdgeInsets.only(bottom: 15),
                //           decoration: BoxDecoration(
                //               border: Border(
                //                   bottom: BorderSide(
                //                       width: 1,
                //                       color: AppColors.greyColor
                //                   )
                //               )
                //           ),
                //           padding: const EdgeInsets.only(bottom: 15),
                //           child: Column(
                //             children: [
                //               Row(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   const Text('1',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                //                   const SizedBox(width: 5,),
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       const Text('Магистральдық желілер және инфрақұрылым',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                //                       Text('Код : B165',style: TextStyle(fontSize: 10,color: AppColors.greyColor),),
                //                     ],
                //                   )
                //                 ],
                //               ),
                //
                //               // GestureDetector(
                //               //   onTap: (){
                //               //     context.push('/profilePage/profileUniversity/profileUniversityDetails');
                //               //   },
                //               //     child: const UniversityCard()
                //               // ),
                //             ],
                //           )
                //
                //       );
                //     }
                // ),


                const SizedBox(height: 100,),
          
              ],
            ),
          ),
        ),
      )
    );
  }
}
