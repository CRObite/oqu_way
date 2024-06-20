import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentViewCheckRow extends StatelessWidget {
  const CommentViewCheckRow({
    Key? key,
    required this.iconSize,
    required this.fontSize,
    required this.onCommentsTap
  }) : super(key: key);

  final double iconSize;
  final double fontSize;
  final VoidCallback onCommentsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/ic_eye.svg',
              height: iconSize,
            ),
            const SizedBox(width: 6),
            Text(
              '3044',
              style: TextStyle(fontSize: fontSize),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onCommentsTap,
              child: SvgPicture.asset(
                'assets/icons/ic_comments.svg',
                height: iconSize,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '129',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/icons/ic_bookmark.svg',
            height: iconSize,
          ),
        ),
      ],
    );
  }
}
