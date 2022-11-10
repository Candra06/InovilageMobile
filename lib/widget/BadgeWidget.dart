import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/TextWidget.dart';

class BadgeWidget extends StatelessWidget {
  final String text, type;
  final Color? bgColor, textColor;
  const BadgeWidget({
    Key? key,
    required this.text,
    this.type = 'large',
    this.bgColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: type == 'large' ? 12 : 4,
        horizontal: type == 'large' ? defaultMargin : 12,
      ),
      decoration: BoxDecoration(
        color: bgColor.runtimeType == Null ? primaryColor : bgColor,
        borderRadius: BorderRadius.circular(
          type == 'large' ? defaultBorderRadius : 8,
        ),
      ),
      child: Center(
        child: TextWidget(
          label: text,
          type: 'l1',
          weight: 'medium',
          color: textColor.runtimeType == Null ? whiteColor : textColor,
        ),
      ),
    );
  }
}
