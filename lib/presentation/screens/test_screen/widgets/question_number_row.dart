import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';

class QuestionNumberRow extends StatefulWidget {
  const QuestionNumberRow({super.key, required this.currentQuestionIndex, required this.onSelectQuestion, required this.questionNumber, this.color});

  final int currentQuestionIndex;
  final int questionNumber;
  final Function(int) onSelectQuestion;
  final Color? color;

  @override
  State<QuestionNumberRow> createState() => _QuestionNumberRowState();
}

class _QuestionNumberRowState extends State<QuestionNumberRow> {

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuestionNumberRow oldWidget) {

    _scrollToIndex(widget.currentQuestionIndex);
    super.didUpdateWidget(oldWidget);
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      (index * 45.0) - 3 * 45.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    bool isTablet = MediaQuery.of(context).size.width > 600;

    return SizedBox(
      height: isTablet? 60 : 40,
      child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: widget.questionNumber,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                _scrollToIndex(index);
                widget.onSelectQuestion(index);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                height: isTablet? 60 : 40,
                width: isTablet? 60 : 40,
                decoration:  widget.color == null?  BoxDecoration(
                    color:  index < widget.currentQuestionIndex ?
                    AppColors.blueColor.withOpacity(0.5):
                    index > widget.currentQuestionIndex ? AppColors.greyColor.withOpacity(0.5):
                    AppColors.blueColor,
                    shape: BoxShape.circle
                ): BoxDecoration(
                    color:  index < widget.currentQuestionIndex ?
                    widget.color!.withOpacity(0.5):
                    index > widget.currentQuestionIndex ?  widget.color!.withOpacity(0.5):
                    widget.color,
                    shape: BoxShape.circle
                ),

                child: Center(
                    child: Text(
                      '${index+1}',
                      style: const TextStyle(fontSize: 16,color: Colors.white),)
                ),
              ),
            );
          }
      ),
    );
  }
}
