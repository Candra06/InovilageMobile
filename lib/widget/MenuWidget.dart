import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/TextWidget.dart';

class MenuWidget extends StatelessWidget {
  final String title;
  final Function onPress;
  final bool useBg;
  const MenuWidget({
    Key? key,
    required this.title,
    required this.onPress,
    this.useBg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: 12,
        ),
        margin: EdgeInsets.only(
          bottom: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: useBg ? primaryColor : whiteColor,
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              label: title,
              type: 'b2',
              color: useBg ? whiteColor : fontPrimaryColor,
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              color: useBg ? whiteColor : fontPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
