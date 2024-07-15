import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_colors.dart';
import 'package:oqu_way/data/repository/comment_repository/comment_repository.dart';
import 'package:oqu_way/data/repository/university_repository/university_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';

import '../../../../config/app_text.dart';
import '../../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../../domain/university.dart';
import '../../news_screen/widgets/news_card.dart';

class ProfileUniversityDetails extends StatefulWidget {
  const ProfileUniversityDetails({super.key, required this.universityId});

  final int? universityId;

  @override
  State<ProfileUniversityDetails> createState() => _ProfileUniversityDetailsState();
}

class _ProfileUniversityDetailsState extends State<ProfileUniversityDetails> {

  University? university;
  bool isLoading = true;

  @override
  void initState() {
    if(widget.universityId!= null){
      getUniversity();
    }

    super.initState();
  }

  Future<void> getUniversity() async {

    University? value = await UniversityRepository().getUniversityById(TempToken.token,  widget.universityId!);



    setState(() {
      university = value;
    });


    setState(() {
      isLoading = false;
    });
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
        title:university!= null ?  Text('${AppText.universities} > ${university!.name}', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),): const SizedBox(),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.blueColor,),): Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    border: Border.all(width: 2,color: AppColors.blueColor),
                    borderRadius: const BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.all(5),
                child: FutureBuilder<Uint8List?>(
                  future: MediaFileRepository().downloadFile(TempToken.token, university!.mediaFiles!.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          height: 60,
                          width: 60,
                          child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,))
                      );
                    } else if (snapshot.hasError) {
                      return const NoImagePhoto(height: 60, width: 60);
                    } else if (!snapshot.hasData) {
                      return const NoImagePhoto(height: 60, width: 60);
                    } else {
                      return Image.memory(snapshot.data!);
                    }
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 58),
                child: Text(university!.name ?? '???',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.moreDarkerBlueColor),),
              ),
              const SizedBox(height: 10,),
              Text('${university!.city!.name} қаласы, ${university!.address}',style: TextStyle(fontSize: 10, color: AppColors.moreDarkerBlueColor),),
              Text('Код : ${university!.code}',style: TextStyle(fontSize: 10, color: AppColors.moreDarkerBlueColor),),
          
              const SizedBox(height: 20,),
          
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Орташа бағасы',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text('${university!.middlePrice} тг',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Статус',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text(university!.status ?? 'белгысыз',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Жатақхана',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text(university!.dormitory! ? 'бар': 'жоқ',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Әскери кафедра',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.moreDarkerBlueColor),),
                        Text(university!.militaryDepartment! ? 'бар': 'жоқ',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
          
                  ],
                ),
              ),
          
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      context.push('/profileUniversityDetails/profileUniversityProfession',
                        extra: {'universityId': university!.id}
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                            top: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                          )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Мамандықтар',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('${university!.specializations!.length}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.greenColor),),
                        ],
                      ),
                    ),
                  ),
          
                  GestureDetector(
                    onTap: (){
                      context.push('/profileComments', extra: {'id': university!.id, 'type':'${CommentType.University}'});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                            top: BorderSide(
                                width: 1,color: AppColors.greyColor
                            ),
                          )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Сұрақтар',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('666',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.greenColor),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Қысқаша сипаттама',style: TextStyle(fontSize: 11, color: AppColors.greenColor),),
                  const SizedBox(height: 10,),
                  Text(university!.description ?? '???'
                      ,style: const TextStyle(fontSize: 12),)
                ],
              )
          
            ],
          ),
        ),
      ),

    );
  }
}
