import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/TextWidget.dart';

Map<String, dynamic> types = {
  "info": {
    "icon": Icons.circle_notifications_outlined,
    "background": primaryColor,
    "textColor": whiteColor
  },
  "success": {
    "icon": Icons.check,
    "background": greenColor,
    "textColor": whiteColor
  },
  "warning": {
    "icon": Icons.warning_amber_outlined,
    "background": yellowColor,
    "textColor": whiteColor
  },
  "error": {
    "icon": Icons.error_outline,
    "background": redColor,
    "textColor": whiteColor
  },
};

void showSnackBar(
  BuildContext context,
  String title, {
  String subtitle = '',
  String type = 'info',
  int duration = 2,
  String position = 'bottom',
}) {
  double barWidth = MediaQuery.of(context).size.width - defaultMargin;
  var theme = types[type];

  final snackBar = SnackBar(
    elevation: 0,
    content: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme['background'],
      ),
      width: barWidth,
      margin: EdgeInsets.all(defaultMargin / 2),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      height: defaultMargin * (subtitle == '' ? 3 : 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            theme['icon'],
            color: Colors.white,
          ),
          SizedBox(
            width: defaultMargin,
          ),
          SizedBox(
            width: barWidth - defaultMargin * 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               const TextWidget(
                  // label: title,
                  // type: 'b2',
                  // weight: 'bold',
                  // color: theme['textColor'],
                  // textOverflow: TextOverflow.ellipsis,
                  // lineHeight: 1.1,
                  // maxLines: 2,
                ),
                subtitle != ''
                    ?const TextWidget(
                        // label: subtitle,
                        // type: 'l1',
                        // color: theme['textColor'],
                        // maxLines: 2,
                        // textOverflow: TextOverflow.ellipsis,
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    ),
    duration: Duration(seconds: duration),
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      top: 0,
      left: 0,
      right: 0,
      bottom: position.toUpperCase() == 'TOP'
          ? MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top -
              100
          : 0,
    ),
    padding: const EdgeInsets.all(0),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}