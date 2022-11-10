import 'package:flutter/material.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: defaultMargin,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(
          defaultBorderRadius,
        ),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                label: "Tanggal : 01 Juli 2022 - 09 : 00",
                color: fontPrimaryColor,
                type: 'l1',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: TextWidget(
                  label: "Jenis : Sampah Organik",
                  color: fontPrimaryColor,
                  type: 'l1',
                ),
              ),
              TextWidget(
                label: "Tujuan : Bank Sampah YASINAT",
                color: fontPrimaryColor,
                type: 'l1',
              ),
            ],
          ),
          const BadgeWidget(
            text: "Sukses",
            type: 'small',
          ),
        ],
      ),
    );
  }
}
