import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../data/repository/media_file_repositry/media_file_repository.dart';
import '../../../../domain/face_subject.dart';
import '../../../../domain/university.dart';
import '../../news_screen/widgets/news_card.dart';

class UniversityCard extends StatefulWidget {
  const UniversityCard({super.key, this.university, this.popUntil = false});

  final dynamic university;
  final bool popUntil;

  @override
  State<UniversityCard> createState() => _UniversityCardState();
}

class _UniversityCardState extends State<UniversityCard> {
  Uint8List? image;
  University?  university;


  @override
  void initState() {

    setState(() {
      university = University.fromJson(widget.university);
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        if(widget.popUntil){
          context.pop();
          context.pop();
          context.pop();
          context.pop();
        }

        context.push('/profileUniversityDetails', extra: {'universityId':university!.id });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: AppShadow.litherShadow
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
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
            const SizedBox(width: 17,),

            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university!.name,
                      style: const TextStyle(fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Мамандық саны: ${university!.specializations!.length}',
                      style: TextStyle(fontSize: 8,
                          color: AppColors.greyColor),
                    ),
                    Text(
                      '${university!.city.name} қаласы, ${university!.address}',
                      style: TextStyle(fontSize: 8,
                          color: AppColors.greyColor),
                    ),
                  ],
                )
            ),

            const SizedBox(width: 17,),
            Icon(Icons.arrow_forward_ios_rounded, color:AppColors.greyColor,size: 20,)
          ],
        ),
      ),
    );
  }
}
