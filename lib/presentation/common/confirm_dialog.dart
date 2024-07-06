import 'package:flutter/material.dart';
import 'package:oqu_way/config/app_colors.dart';

class ConfirmDialog{
  static void showConfirmationDialog(BuildContext context, String title,String yes, String no, VoidCallback onYesPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          content: Text(title,textAlign: TextAlign.center,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          actions: <Widget>[
            Column(
              children: [
                const Divider(),

                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(yes,style: const TextStyle(color: Colors.red,fontSize: 15),),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onYesPressed();
                        },
                      ),

                      const SizedBox(
                        height: 40, // Adjust the height as needed
                        child: VerticalDivider(
                          thickness: 1, // Adjust the thickness as needed
                        ),
                      ),

                      TextButton(
                        child: Text(no,style: TextStyle(color: AppColors.blueColor,fontSize: 15),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}