import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/data/repository/auth_reg_repository/authorization_repository.dart';
import 'package:oqu_way/data/repository/post_repository/post_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/domain/pagination.dart';
import 'package:oqu_way/presentation/common/pagination_builder.dart';
import 'package:oqu_way/presentation/screens/news_screen/widgets/news_card.dart';
import 'package:oqu_way/util/custom_exeption.dart';

import '../../../domain/post.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(AppText.news, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),

            PaginationBuilder(
                size: 10,
                type: PageableType.news,
                child: (context, post) => NewsCard(post: post),
            ),


            const SizedBox(height: 69,),
          ],
        ),
      ),
    );
  }
}
