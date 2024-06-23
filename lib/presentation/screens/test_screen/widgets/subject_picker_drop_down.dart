import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_colors.dart';

class SubjectPickerDropDown extends StatefulWidget {
  const SubjectPickerDropDown({super.key, required this.valuesWithExtra, required this.selectedValue, required this.onValueSelected, required this.hint});

  final List<String> valuesWithExtra;
  final String selectedValue;
  final Function(String) onValueSelected;
  final String hint;

  @override
  State<SubjectPickerDropDown> createState() => _SubjectPickerDropDownState();
}

class _SubjectPickerDropDownState extends State<SubjectPickerDropDown> {


  String selected = '';

  @override
  void initState() {
    setState(() {
      selected = widget.selectedValue;
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(width: 2, color: AppColors.greyColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            hint: Text(widget.hint, style: TextStyle(color: AppColors.greyColor.withOpacity(0.5)),),
            value: selected.isNotEmpty ? selected : null,
            onChanged: (String? newValue) {
              if(newValue!= null){
                setState(() {
                  selected = newValue;
                });

                widget.onValueSelected(newValue);
              }
            },
            items: widget.valuesWithExtra.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            iconStyleData: IconStyleData(
                icon:  Transform.rotate(
                  angle: 90 * 3.1415926535/180,
                  child: SvgPicture.asset(
                    'assets/icons/ic_arrow.svg',
                    height: 11,
                    width: 5,
                  ),
                )
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            isExpanded: true,
            underline: Container(),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
