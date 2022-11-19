import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/TextWidget.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final bool centerTitle, hideBackPress;
  final Function? onPressBack;
  const HeaderWidget({
    Key? key,
    required this.title,
    this.color,
    this.centerTitle = true,
    this.onPressBack,
    this.hideBackPress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hideBackPress
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    onPressBack.runtimeType == Null
                        ? Navigator.pop(context)
                        : onPressBack!();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: color.runtimeType == Null ? secondaryColor : color,
                  ),
                ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: TextWidget(
              label: title,
              weight: "bold",
              type: "s2",
              color: color.runtimeType == Null ? secondaryColor : color,
              textAlign: centerTitle ? TextAlign.center : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
