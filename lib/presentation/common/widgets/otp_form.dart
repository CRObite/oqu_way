import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/app_colors.dart';

class OtpForm extends StatefulWidget {
  final void Function(String) onOtpEntered;
  final bool isWrong;

  const OtpForm({
    Key? key,
    required this.onOtpEntered,
    required this.isWrong,
  }) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<bool> _isSet = List.generate(4, (index) => false);

  bool _isWrong = false;

  @override
  void initState() {
    super.initState();
    _isWrong = widget.isWrong;
  }

  @override
  void didUpdateWidget(covariant OtpForm oldWidget) {
    _isWrong = widget.isWrong;
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged(String value, int index) {
    setState(() {
      _isSet[index] = value.isNotEmpty;
      if (_isWrong) {
        _isWrong = false;
      }
    });

    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    } else if (value.length == 1) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }

    bool allFilled = _controllers.every((controller) => controller.text.isNotEmpty);
    if (allFilled) {
      FocusScope.of(context).unfocus();
      String otp = _controllers.map((controller) => controller.text).join();
      widget.onOtpEntered(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 68,
                width: 45,
                child: TextFormField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (value) => _onChanged(value, index),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none, // Remove underline
                  ),
                ),
              ),
              Container(
                height: 5,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: _isWrong ? Colors.red : (_isSet[index] ? AppColors.blueColor : Colors.black),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
