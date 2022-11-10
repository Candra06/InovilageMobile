import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/TextWidget.dart';

class ModalWidget extends StatelessWidget {
  final Widget content;
  final String title;
  const ModalWidget({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        color: whiteColor,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: defaultMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 54,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100,
                ),
                color: Colors.blueGrey.shade200,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: defaultMargin,
            ),
            child: TextWidget(
              label: title,
              weight: "bold",
              type: 's3',
            ),
          ),
          content,
        ],
      ),
    );
  }
}
