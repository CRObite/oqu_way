import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:oqu_way/config/app_shadow.dart';

import '../../../config/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.title, required this.controller, required this.type,this.hint = '', this.editable = true,this.maxLines = 1,});

  final String title;
  final String hint;
  final TextEditingController controller;
  final bool editable;
  final int maxLines;
  final TextInputType type;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  static MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ### - ## - ##',
    filter: { "#": RegExp(r'[0-9]') },
  );


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,style: const TextStyle(fontSize: 12),),
        const SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: AppShadow.textFieldShadow,
              border: Border.all(
                  width: 2,
                  color: AppColors.greyColor
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 2,bottom: 2, left: 16),
            child: TextFormField(
              obscureText: widget.type == TextInputType.visiblePassword ? _obscureText : false,
              maxLines: widget.maxLines,
              controller: widget.controller,
              enabled: widget.editable,
              keyboardType: widget.type,
              inputFormatters: widget.type == TextInputType.phone ? [maskFormatter]: null,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: widget.type == TextInputType.visiblePassword?  15: 0),
                border: InputBorder.none,
                hintText: widget.hint,
                suffixIcon: widget.type == TextInputType.visiblePassword ? IconButton(
                  splashColor: Colors.transparent,
                  color: AppColors.greyColor,
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(_obscureText ? Icons.visibility_outlined: Icons.visibility_off_outlined),
                ): null,
              ),
            )
          ),
        )
      ],
    );
  }
}
