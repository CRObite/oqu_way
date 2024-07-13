
import 'package:flutter/material.dart';
import 'package:oqu_way/config/app_text.dart';
import 'package:oqu_way/presentation/common/pagination_builder.dart';
import 'package:oqu_way/presentation/screens/news_screen/widgets/news_card.dart';



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

            Text(AppText.news, style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),

            Expanded(
              child: PaginationBuilder(
                size: 10,
                bottomSize: 96,
                type: PageableType.news,
                child: (context, post) => NewsCard(post: post),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
