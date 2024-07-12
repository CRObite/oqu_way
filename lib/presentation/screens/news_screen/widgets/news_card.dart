import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/config/app_formatter.dart';
import 'package:oqu_way/config/app_image_loading.dart';
import 'package:oqu_way/data/repository/media_file_repositry/media_file_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/domain/media_file.dart';
import 'package:oqu_way/presentation/common/card_container_decoration.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_image.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../../domain/post.dart';
import '../../../common/widgets/comment_view_check_row.dart';
import '../../../common/widgets/common_button.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({super.key, required this.post});

  final dynamic post;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {


  Post? post;

  @override
  void initState() {
    print(widget.post);
    post = Post.fromJson(widget.post);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.goNamed('newsDetails', extra: {'newsId': post!.id});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: CardContainerDecoration.decoration,
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10),),
                color: Colors.white,
                boxShadow: AppShadow.shadow,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child:
                FutureBuilder<Uint8List?>(
                  future: MediaFileRepository().downloadFile(TempToken.token, post!.mediaFiles!.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          height: 70, width: double.infinity,
                          child: Center(child: CircularProgressIndicator(color: AppColors.blueColor,)));
                    } else if (snapshot.hasError) {
                      return const NoImagePhoto(height: 70, width: double.infinity);
                    } else if (!snapshot.hasData) {
                      return const NoImagePhoto(height: 70, width: double.infinity);
                    } else {
                      return Image.memory(snapshot.data!, fit: BoxFit.cover,width: double.infinity,);
                    }
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(post!.title ?? '???', maxLines: 2,overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),
                      const SizedBox(width: 8,),
                      SizedBox(
                          height: 20,
                          width: 40,
                          child: CommonButton(title: AppText.read,fontSize: 8,verticalPadding: 4,horizontalPadding: 8, onClick: () {  },)
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        post!.dateTime!= null ? AppFormatter.getFormattedDate(post!.dateTime!) : '???',
                        style: const TextStyle(fontSize: 8),
                      )
                  ),

                  Divider(color: AppColors.greyColor,),

                  CommentViewCheckRow(iconSize: 10, fontSize: 8, onCommentsTap: () {},),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class NoImagePhoto extends StatelessWidget {
  const NoImagePhoto({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: Colors.white,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, size: 40,),
      ),
    );
  }
}
