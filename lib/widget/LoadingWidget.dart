import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';


class LoadingWidget extends StatelessWidget {
  final double customWidth, customHeight;
  const LoadingWidget({
    Key? key,
    this.customWidth = 100,
    this.customHeight = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: customHeight,
        width: customWidth,
        margin: const EdgeInsets.only(
          right: 12,
          top: 12,
        ),
        child: CircularProgressIndicator(
          backgroundColor: primaryColor,
          color: whiteColor,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
