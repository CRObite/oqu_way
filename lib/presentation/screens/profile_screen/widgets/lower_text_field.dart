import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LowerTextFiled extends StatelessWidget {
  const LowerTextFiled({super.key, required this.title, required this.controller, required this.type});

  final String title;
  final TextEditingController controller;
  final TextInputType type;


  static MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ### - ## - ##',
    filter: { "#": RegExp(r'[0-9]') },
  );


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontSize: 11,color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),),
          TextField(
            keyboardType: type,
            inputFormatters: type == TextInputType.phone ? [maskFormatter]: null,
            controller: controller,
          )
        ],
      ),
    );
  }
}
