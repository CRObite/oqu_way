import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_colors.dart';
import '../../../../domain/subject.dart';

class SubjectPickerDropDown extends StatefulWidget {
  const SubjectPickerDropDown({super.key, required this.valuesWithExtra, required this.onValueSelected, required this.hint});

  final List<Subject> valuesWithExtra;
  final Function(Subject) onValueSelected;
  final String hint;

  @override
  State<SubjectPickerDropDown> createState() => _SubjectPickerDropDownState();
}

class _SubjectPickerDropDownState extends State<SubjectPickerDropDown> {


  Subject? selected;



  @override
  void didUpdateWidget(covariant SubjectPickerDropDown oldWidget) {

    if(oldWidget.valuesWithExtra != widget.valuesWithExtra){
      setState(() {
        selected = null;
      });

      print(selected);
    }
    super.didUpdateWidget(oldWidget);
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
        child:
        DropdownButtonHideUnderline(
          child: DropdownButton2<Subject>(
            hint: Text(widget.hint, style: TextStyle(color: AppColors.greyColor.withOpacity(0.5)),),
            value: selected,
            onChanged: (Subject? newValue) {
              if(newValue!= null){
                setState(() {
                  selected = newValue;
                });

                widget.onValueSelected(newValue);
              }
            },
            items: widget.valuesWithExtra.map<DropdownMenuItem<Subject>>((Subject value) {
              return DropdownMenuItem<Subject>(
                value: value,
                child: Text(value.name ?? ''),
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
                thickness: WidgetStateProperty.all(6),
                thumbVisibility: WidgetStateProperty.all(true),
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
