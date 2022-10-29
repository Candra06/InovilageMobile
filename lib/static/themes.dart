import 'package:flutter/material.dart';
import 'package:inovilage/static/HexColor.dart';

double defaultMargin = 16;
double defaultBorderRadius = 12;

Color primaryColor = HexColor('#000000');
Color yellowColor = HexColor('#F6BA41');
Color whiteColor = HexColor('#fffff');
Color lightPrimaryColor = HexColor('#F2EEFF');
Color secondaryColor = HexColor('#7E3FE4');
Color fontPrimaryColor = HexColor('#242B46');
Color fontSecondaryColor = HexColor('#5E6066');
Color fontFiveColor = HexColor('#B3B5BE');
Color fontGreyColor = HexColor('#7F8185');
Color fontGreyColor2 = HexColor('#97989B');
Color borderColor = HexColor('#E7EEFB');
Color redColor = HexColor('#EE4C24');
Color disableColor = HexColor('#DBDEE8');
Color greenColor = HexColor('#48AD64');
Color defaultTextShadowColor = HexColor('#000000');
List<Shadow> generateTextShadow([color]) {
  return [
    Shadow(
      offset: const Offset(1.0, 1.0),
      blurRadius: 3.0,
      color: color ?? defaultTextShadowColor,
    ),
    Shadow(
      offset: const Offset(1.0, 1.0),
      blurRadius: 8.0,
      color: color ?? defaultTextShadowColor,
    ),
  ];
}