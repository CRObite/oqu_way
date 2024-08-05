import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oqu_way/presentation/screens/profile_screen/widgets/specilaization_card.dart';

import '../../../../config/app_text.dart';
import '../../../../domain/specialization.dart';

class SpecializationDropDown extends StatefulWidget {
  const SpecializationDropDown({super.key, required this.title, required this.valuesWithExtra, required this.onValueSelected});

  final String title;
  final List<Specialization> valuesWithExtra;
  final Function(Specialization?) onValueSelected;

  @override
  State<SpecializationDropDown> createState() => _SpecializationDropDownState();
}

class _SpecializationDropDownState extends State<SpecializationDropDown> {

  Specialization? selected;


  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;

    return Row(
      children: [
        Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),
        const SizedBox(width: 10,),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Specialization>(
              hint: Text(AppText.selectSpecialization),
              value: selected,
              onChanged: (Specialization? newValue) {
                if(newValue!= null){
                  setState(() {
                    selected = newValue;
                  });

                  widget.onValueSelected(newValue);
                }
              },
              items: widget.valuesWithExtra.map<DropdownMenuItem<Specialization>>((Specialization value) {
                return DropdownMenuItem<Specialization>(
                  value: value,
                  child: Text(value.name ?? ''),
                );
              }).toList(),
              iconStyleData: IconStyleData(
                  icon: selected != null ?
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          selected = null;
                        });

                        widget.onValueSelected(null);
                      },
                      child: const Icon(Icons.close,size: 18)
                  ):
                  Transform.rotate(
                    angle: 90 * 3.1415926535/180,
                    child: SvgPicture.asset(
                      'assets/icons/ic_arrow.svg',
                      height: isTablet? 15:11,
                      width: 5,
                    ),
                  )
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: isTablet? 300 : 200,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                offset: const Offset(-40, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              isExpanded: true,
              underline: Container(),
              menuItemStyleData: const MenuItemStyleData(
                height: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
