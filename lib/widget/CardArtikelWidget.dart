import 'package:flutter/material.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';

class CardArtikelWidget extends StatefulWidget {
  final String title;
  final Function onPressed;
  const CardArtikelWidget(
      {Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  State<CardArtikelWidget> createState() => _CardArtikelWidgetState();
}

class _CardArtikelWidgetState extends State<CardArtikelWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          ),
        ),
        padding: EdgeInsets.all(
          defaultMargin,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Row(
          children: [
            const Expanded(
              child: ImageWidget(
                image: bgUser,
              ),
            ),
            TextWidget(
              label: widget.title,
              color: whiteColor,
              weight: "bold",
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
