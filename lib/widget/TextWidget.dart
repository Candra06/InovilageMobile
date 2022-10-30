import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inovilage/static/themes.dart';

class TextWidget extends StatelessWidget {
  final String label, weight, type;
  final Color? color;
  final TextAlign textAlign;
  final bool upperCase, useEllipsis;
  final TextOverflow textOverflow;
  final int maxLines;
  final TextDecoration textDecoration;

  const TextWidget({
    Key? key,
    required this.label,
    this.weight = 'regular',
    this.type = 'b1',
    this.color,
    this.textAlign = TextAlign.left,
    this.upperCase = false,
    this.useEllipsis = false,
    this.textOverflow = TextOverflow.visible,
    this.maxLines = 10,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);

  int generateType() {
    switch (type) {
      case 'h1':
        return 36;
      case 'h2':
        return 32;
      case 'h3':
        return 28;
      case 's1':
        return 24;
      case 's2':
        return 20;
      case 's3':
        return 18;
      case 'b1':
        return 16;
      case 'b2':
        return 14;
      case 'l1':
        return 12;
      case 'l2':
        return 10;
      case 'l3':
        return 8;
      default:
        return 16;
    }
  }

  FontWeight generateFontWeight() {
    switch (weight) {
      case 'bold':
        return FontWeight.bold;
      case 'regular':
        return FontWeight.w400;
      case 'medium':
        return FontWeight.w600;
      case 'light':
        return FontWeight.w200;
      default:
        return FontWeight.w400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      !upperCase ? label : label.toUpperCase(),
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: generateType().toDouble(),
          color: color ?? fontPrimaryColor,
          fontWeight: generateFontWeight(),
          decoration: textDecoration,
        ),
      ),
    );
  }
}
