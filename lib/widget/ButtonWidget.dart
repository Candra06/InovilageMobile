import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/TextWidget.dart';

class ButtonWidget extends StatelessWidget {
  final bool isLoading, upperCase;
  final double height, width;
  final String theme, label, type;
  final Function onPressed;
  const ButtonWidget({
    Key? key,
    this.isLoading = false,
    this.height = 48,
    this.width = double.infinity,
    this.theme = 'primary', // disable // outline
    this.type = 'button',
    this.upperCase = false,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  generateColor() {
    switch (theme) {
      case 'primary':
        return primaryColor;
      case 'disable':
        return disableColor;
      default:
        return primaryColor;
    }
  }

  generateFontColor() {
    switch (theme) {
      case 'primary':
        if (type == 'button') {
          return whiteColor;
        } else {
          return primaryColor;
        }
      case 'disable':
        return fontDisableColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: type == 'outline' && theme == 'primary'
            ? transparentColor
            : generateColor(),
        border: type == 'outline' && theme == 'primary'
            ? Border.all(
                color: generateColor(),
              )
            : null,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Material(
        color: transparentColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(
            5,
          ),
          onTap: isLoading || theme == 'disable'
              ? () {}
              : () {
                  onPressed();
                },
          highlightColor:
              theme == 'disable' || isLoading ? transparentColor : null,
          focusColor: theme == 'disable' || isLoading ? transparentColor : null,
          hoverColor: theme == 'disable' || isLoading ? transparentColor : null,
          splashColor:
              theme == 'disable' || isLoading ? transparentColor : null,
          child: Center(
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(
                          right: 8,
                        ),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            generateFontColor(),
                          ),
                        ),
                      ),
                      TextWidget(
                        label: "Loading...",
                        weight: 'bold',
                        color: generateFontColor(),
                      )
                    ],
                  )
                : TextWidget(
                    label: label,
                    upperCase: upperCase,
                    weight: 'bold',
                    color: generateFontColor(),
                  ),
          ),
        ),
      ),
    );
  }
}
