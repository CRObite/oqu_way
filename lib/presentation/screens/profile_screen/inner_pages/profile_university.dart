import 'package:flutter/material.dart';
import 'package:oqu_way/data/repository/dictionary_repository/dictionary_repository.dart';
import 'package:oqu_way/domain/face_subject.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/university_card.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_text.dart';
import '../../../../data/local/shared_preferences_operator.dart';
import '../../../../domain/city.dart';
import '../../../blocs/pagination_builder/pagination_builder_cubit/pagination_builder_cubit.dart';
import '../../../common/pagination_builder.dart';
import '../../../common/widgets/common_search_field.dart';

class ProfileUniversity extends StatefulWidget {
  const ProfileUniversity({super.key});

  @override
  State<ProfileUniversity> createState() => _ProfileUniversityState();
}

class _ProfileUniversityState extends State<ProfileUniversity> {

  bool isOpened = false;
  List<City> cities = [];

  TextEditingController searchController = TextEditingController();
  String query = '';
  int? selectedCity;

  @override
  void initState() {
    getCities();
    super.initState();
  }

  Future<void> getCities() async {

    String? token = await SharedPreferencesOperator.getAccessToken();
    List<City> values = await DictionaryRepository().getAllCities(token!);
    setState(() {
      cities = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CommonSearchField(searchController: searchController, onEnded: (){
                  setState(() {query = searchController.text;});
                },),
              ),


              isOpened ? const SizedBox(): Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.greyColor,
                      width: 1
                    ),
                    top: BorderSide(
                        color: AppColors.greyColor,
                        width: 1
                    ),
                  )
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Қаланы таңдаңыз', style: TextStyle(color: AppColors.greyColor),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOpened = true;
                        });
                      },
                      child: Row(
                        children: [
                          Text(selectedCity!= null ? cities[selectedCity!].name : '',style: TextStyle(color: AppColors.greyColor),),
                          Icon(Icons.arrow_forward_ios_rounded, color:AppColors.greyColor,size: 12,)
                        ],
                      ),
                    )
                  ],
                ),
              ),


              isOpened?
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  padding: const EdgeInsets.only(bottom: 100),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          isOpened = false;
                          selectedCity = index;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(cities[index].name),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  }
                ),
              ): Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PaginationBuilder(
                    size: 10,
                    onRefreshed:(){
                      setState(() {
                        searchController.text = '';
                        selectedCity = null;
                      });
                    },
                    bottomSize: 96,
                    type: PageableType.universities,
                    query: query,
                    cityId: selectedCity!= null ? cities[selectedCity!].id: null,
                    child: (context, university) => UniversityCard(university: university),
                  ),
                ),
              ),

            ],
        ),
      ),
    );
  }
}
