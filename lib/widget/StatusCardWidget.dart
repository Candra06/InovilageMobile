import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/DonasiProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class StatusCardWidget extends StatefulWidget {
  final Map data;
  final String transType;
  const StatusCardWidget({
    Key? key,
    required this.data,
    this.transType = 'pengiriman',
  }) : super(key: key);

  @override
  State<StatusCardWidget> createState() => _StatusCardWidgetState();
}

class _StatusCardWidgetState extends State<StatusCardWidget> {
  getDetail(String id, String type) async {
    if (widget.transType == 'pengiriman') {
      Provider.of<PengirimanProvider>(
        context,
        listen: false,
      )
          .getDetailPengiriman(
        id,
      )
          .then((value) {
        if (value['code'] == '00') {
          if (type == 'detail') {
            if (widget.transType == 'pengiriman') {
              Navigator.pushNamed(
                context,
                Navigation.detailPengirimanScreen,
                arguments: id,
              );
            } else {
              Navigator.pushNamed(
                context,
                Navigation.detailDonaiScreen,
                arguments: id,
              );
            }
          } else {
            Navigator.pushNamed(
              context,
              Navigation.addItemPengirimanScreen,
              arguments: id,
            );
          }
        }
      });
    } else {
      Provider.of<DonasiProvider>(
        context,
        listen: false,
      )
          .getDetailPengiriman(
        id,
      )
          .then((value) {
        if (value['code'] == '00') {
          if (type == 'detail') {
            Navigator.pushNamed(
              context,
              Navigation.detailDonaiScreen,
              arguments: id,
            );
          } else {
            Navigator.pushNamed(
              context,
              Navigation.addItemDonaiScreen,
              arguments: id,
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      if (auth.authData!.role == 'Admin') {
        return InkWell(
          onTap: () {
            getDetail(
              widget.data['id'].toString(),
              'detail',
            );
          },
          child: Container(
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
                            label: "#${widget.data['kode_transaksi']}",
                            type: 'l1',
                            color: fontPrimaryColor,
                          ),
                          TextWidget(
                            label: "${widget.data['alamat_jemput']}",
                            type: 'l1',
                            useEllipsis: true,
                            maxLines: 1,
                            color: fontPrimaryColor,
                          ),
                          TextWidget(
                            label: "Kurir : ${widget.data['name']}",
                            type: 'l1',
                            color: fontPrimaryColor,
                          )
                        ],
                      ),
                      BadgeWidget(
                        text: "${widget.data['status']}",
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
                              "Tanggal : ${dateFormatDay(context, format: "dd MMMM yyy hh:mm", value: widget.data['tanggal'])}",
                          color: fontPrimaryColor,
                          type: 'l1',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: TextWidget(
                            label: "Jenis : ${widget.data['jenis_sampah']}",
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
          ),
        );
      } else if (auth.authData!.role == 'Kurir') {
        return InkWell(
          onTap: () {
            getDetail(
              widget.data['id'].toString(),
              widget.data['status'] != 'Menunggu Kurir' ? 'detail' : 'add',
            );
          },
          child: Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              label: "#${widget.data['kode_transaksi']}",
                              type: 'l1',
                              color: fontPrimaryColor,
                            ),
                            TextWidget(
                              label: "${widget.data['alamat_jemput']}",
                              type: 'l1',
                              useEllipsis: true,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              color: fontPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      BadgeWidget(
                        text: "${widget.data['status']}",
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
                              "Tanggal : ${dateFormatDay(context, format: "dd MMMM yyy hh:mm", value: widget.data['tanggal'])}",
                          color: fontPrimaryColor,
                          type: 'l1',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          child: TextWidget(
                            label: "Jenis : ${widget.data['jenis_sampah']}",
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
          ),
        );
      } else {
        return InkWell(
          onTap: () {
            getDetail(
              widget.data['id'].toString(),
              'detail',
            );
          },
          child: Container(
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
                      label:
                          "Tanggal : ${dateFormatDay(context, format: "dd MMMM yyy hh:mm", value: widget.data['tanggal'])}",
                      color: fontPrimaryColor,
                      type: 'l1',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: TextWidget(
                        label: "Jenis : ${widget.data['jenis_sampah']}",
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
                BadgeWidget(
                  text: "${widget.data['status']}",
                  type: 'small',
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
