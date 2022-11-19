import 'package:flutter/material.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class StatusCardWidget extends StatelessWidget {
  final Map data;
  const StatusCardWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      if (auth.authData!.role != 'Pengguna') {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: defaultMargin,
          ),
          margin: EdgeInsets.only(
            bottom: defaultMargin / 2,
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: bordergreyColor,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                margin: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          label: "#${data['kode_transaksi']}",
                          type: 'l1',
                          color: fontPrimaryColor,
                        ),
                        TextWidget(
                          label: "${data['alamat_jemput']}",
                          type: 'l1',
                          useEllipsis: true,
                          maxLines: 1,
                          color: fontPrimaryColor,
                        ),
                        TextWidget(
                          label: "Kurir : ${data['name']}",
                          type: 'l1',
                          color: fontPrimaryColor,
                        )
                      ],
                    ),
                    BadgeWidget(
                      text: "${data['status']}",
                      type: 'small',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        label:
                            "Tanggal : ${dateFormatDay(context, format: "dd MMMM yyy hh:mm", value: data['tanggal'])}",
                        color: fontPrimaryColor,
                        type: 'l1',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: TextWidget(
                          label: "Jenis : ${data['jenis_sampah']}",
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
                ],
              ),
            ],
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: defaultMargin,
          ),
          margin: EdgeInsets.only(
            bottom: defaultMargin / 2,
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
    });
  }
}
