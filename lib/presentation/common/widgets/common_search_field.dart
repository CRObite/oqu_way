import 'package:flutter/material.dart';
import 'package:oqu_way/config/app_colors.dart';

import '../../../config/app_text.dart';

class CommonSearchField extends StatelessWidget {
  const CommonSearchField({super.key, required this.searchController, required this.onEnded});

  final TextEditingController searchController;
  final VoidCallback onEnded;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              width: 1,
              color: AppColors.greyColor
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Icon(Icons.search_rounded,color: AppColors.greyColor,),
            const SizedBox(width: 10,),
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  onEditingComplete: onEnded,
                  controller: searchController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 5),
                    border: InputBorder.none,
                    hintText: AppText.search,
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
