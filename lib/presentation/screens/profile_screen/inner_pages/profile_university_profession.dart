import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oqu_way/domain/specialization.dart';
import 'package:oqu_way/presentation/common/pagination_builder.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/specilaization_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_shadow.dart';
import '../../../../config/app_text.dart';
import '../../../blocs/pagination_builder/pagination_builder_cubit/pagination_builder_cubit.dart';
import '../../../common/widgets/common_search_field.dart';

class ProfileUniversityProfession extends StatefulWidget {
  const ProfileUniversityProfession({super.key, required this.universityId});

  final int? universityId;

  @override
  State<ProfileUniversityProfession> createState() => _ProfileUniversityProfessionState();
}

class _ProfileUniversityProfessionState extends State<ProfileUniversityProfession> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    print(widget.universityId);
    super.initState();
  }

  String query = '';



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
        title: Text('${AppText.universities} > Мамандықтар', style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CommonSearchField(searchController: searchController, onEnded: () { setState(() {query = searchController.text;}); },),

            Expanded(
              child: PaginationBuilder(
                size: 10,
                type: PageableType.specialization,
                query: query,
                universityId: widget.universityId,
                child: (context, specialization) => SpecializationCard(specialization: specialization,),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
