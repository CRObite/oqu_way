import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_text.dart';

class SpecializationDropDown extends StatefulWidget {
  const SpecializationDropDown({super.key, required this.title, required this.valuesWithExtra, required this.selectedValue, required this.onValueSelected});

  final String title;
  final List<String> valuesWithExtra;
  final String selectedValue;
  final Function(String) onValueSelected;

  @override
  State<SpecializationDropDown> createState() => _SpecializationDropDownState();
}

class _SpecializationDropDownState extends State<SpecializationDropDown> {

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
    return Row(
      children: [
        Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(width: 10,),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              hint: Text(AppText.selectSpecialization),
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
                  icon: selected.isNotEmpty ?
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          selected = '';
                        });

                        widget.onValueSelected('');
                      },
                      child: const Icon(Icons.close,size: 18)
                  ):
                  Transform.rotate(
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
                width: MediaQuery.of(context).size.width - 50,
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
      ],
    );
  }
}
