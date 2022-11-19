import 'package:flutter/material.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/model/DetailPengirimanModel.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class DetailPengirimanScreen extends StatefulWidget {
  final String id;
  const DetailPengirimanScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailPengirimanScreen> createState() => _DetailPengirimanScreenState();
}

class _DetailPengirimanScreenState extends State<DetailPengirimanScreen> {
  getDetail() async {
    Provider.of<PengirimanProvider>(
      context,
      listen: false,
    ).getDetailPengiriman(
      widget.id,
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // getDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(child: Consumer<PengirimanProvider>(
        builder: (context, value, child) {
          DetailPengirimanModel data = value.detailPengiriman;
          double totalOrganik = 0, totalAnorganik = 0;
          for (var element in data.itemOrganik!) {
            totalOrganik += num.tryParse(element.volume!)!.toDouble();
          }
          for (var element in data.itemAnorganik!) {
            totalOrganik += num.tryParse(element.volume!)!.toDouble();
          }
          return Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  AuthModel authData = auth.authData!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderWidget(
                        title: "Detail Pengiriman",
                      ),
                      SizedBox(
                        height: defaultMargin,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  defaultBorderRadius,
                                ),
                              ),
                              border: Border.all(
                                color: primaryColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                    defaultMargin,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      authData.role == 'Pengguna'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  label:
                                                      "Tanggal : ${dateFormatDay(
                                                    context,
                                                    format: "dd MMMM yyy hh:mm",
                                                    value:
                                                        '2022-11-09 15:10:27',
                                                  )}",
                                                  color: fontPrimaryColor,
                                                  type: 'l1',
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4,
                                                  ),
                                                  child: TextWidget(
                                                    label: "Jenis : Organik",
                                                    color: fontPrimaryColor,
                                                    type: 'l1',
                                                  ),
                                                ),
                                                TextWidget(
                                                  label:
                                                      "Tujuan : Bank Sampah YASINAT",
                                                  color: fontPrimaryColor,
                                                  type: 'l1',
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  label:
                                                      "#${data.kodeTransaksi}",
                                                  color: fontPrimaryColor,
                                                  type: 'l1',
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 4,
                                                  ),
                                                  child: TextWidget(
                                                    label:
                                                        "${data.alamatJemput}",
                                                    color: fontPrimaryColor,
                                                    maxLines: 2,
                                                    useEllipsis: true,
                                                    ellipsisParentWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .6,
                                                    type: 'l1',
                                                  ),
                                                ),
                                              ],
                                            ),
                                      const BadgeWidget(
                                        text: "Selesai",
                                        type: 'large',
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: primaryColor,
                                  height: 1,
                                  thickness: 2,
                                ),
                                authData.role != 'Pengguna'
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: defaultMargin,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: defaultMargin,
                                            ),
                                            TextWidget(
                                              label: "Tanggal : ${dateFormatDay(
                                                context,
                                                format: "dd MMMM yyy hh:mm",
                                                value: data.tanggal!.toString(),
                                              )}",
                                              color: fontPrimaryColor,
                                              type: 'l1',
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: TextWidget(
                                                label:
                                                    "Jenis : ${data.jenisSampah}",
                                                color: fontPrimaryColor,
                                                type: 'l1',
                                              ),
                                            ),
                                            TextWidget(
                                              label:
                                                  "Tujuan : Bank Sampah YASINAT",
                                              color: fontPrimaryColor,
                                              type: 'l1',
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                                Padding(
                                  padding: EdgeInsets.all(
                                    defaultMargin,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      data.itemAnorganik!.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: defaultMargin,
                                                  ),
                                                  child: TextWidget(
                                                    label:
                                                        "Jumlah Sampah Anorganik",
                                                    color: secondaryColor,
                                                    type: 'b1',
                                                  ),
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: data
                                                      .itemAnorganik!.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    Item itemAnorganik = data
                                                        .itemAnorganik![index];
                                                    return cardItem(
                                                      colors: index % 2 == 1
                                                          ? whiteColor
                                                          : greyCardCOlor,
                                                      title:
                                                          itemAnorganik.nama!,
                                                      subtitle:
                                                          "${itemAnorganik.volume!}${itemAnorganik.satuan!} x ${itemAnorganik.hargaSatuan!}/${itemAnorganik.satuan!}",
                                                      endTitle: itemAnorganik
                                                          .hargaSatuan!,
                                                    );
                                                  },
                                                ),
                                                cardItem(
                                                  colors: greyCardCOlor,
                                                  title: "Jumlah",
                                                  subtitle:
                                                      "${totalAnorganik.toString()}kg",
                                                  endTitle:
                                                      "${data.totalamount}",
                                                ),
                                                SizedBox(
                                                  height: defaultMargin,
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      data.itemOrganik!.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: defaultMargin),
                                                  child: TextWidget(
                                                    label:
                                                        "Jumlah Sampah Organik",
                                                    color: secondaryColor,
                                                    type: 'b1',
                                                  ),
                                                ),
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: 3,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return cardItem(
                                                      colors: index % 2 == 1
                                                          ? whiteColor
                                                          : greyCardCOlor,
                                                      title: "Botol Kaca",
                                                      subtitle:
                                                          "1.5kg x 3000/kg",
                                                      endTitle: "4500",
                                                    );
                                                  },
                                                ),
                                                cardItem(
                                                  colors: greyCardCOlor,
                                                  title: "Jumlah",
                                                  subtitle: "4.5kg",
                                                  endTitle: "4500",
                                                ),
                                                SizedBox(
                                                  height: defaultMargin,
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      authData.role != 'Pengguna'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  label: "Pendapatan Kurir",
                                                  color: secondaryColor,
                                                  type: 'b1',
                                                ),
                                                cardItem(
                                                  colors: greyCardCOlor,
                                                  title:
                                                      "10% x ${data.totalamount}",
                                                  subtitle: "",
                                                  endTitle:
                                                      data.kurirfee.toString(),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  label: "Biaya Admin",
                                                  color: secondaryColor,
                                                  type: 'b1',
                                                ),
                                                cardItem(
                                                  colors: greyCardCOlor,
                                                  title:
                                                      "25% x ${data.totalamount}",
                                                  subtitle: "",
                                                  endTitle:
                                                      data.adminfee.toString(),
                                                ),
                                              ],
                                            ),
                                      authData.role != 'Kurir'
                                          ? Container(
                                              width: double.infinity,
                                              child: TextWidget(
                                                label: "Kurir : ${data.kurir}",
                                                color: secondaryColor,
                                                type: 'b1',
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ));
        },
      )),
    );
  }

  Widget cardItem({
    required Color colors,
    required String title,
    required String subtitle,
    required String endTitle,
  }) {
    return Card(
      color: colors,
      child: Container(
        margin: EdgeInsets.only(
          bottom: defaultMargin / 2,
        ),
        padding: EdgeInsets.fromLTRB(
          defaultMargin,
          10,
          defaultMargin,
          4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(defaultMargin / 2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextWidget(
                label: title,
                color: secondaryColor,
                type: 'l1',
              ),
            ),
            Expanded(
              child: TextWidget(
                label: subtitle,
                color: secondaryColor,
                type: 'l1',
              ),
            ),
            Expanded(
              child: TextWidget(
                textAlign: TextAlign.end,
                label: formatrupiah(
                  amount: endTitle,
                  awalan: 'Rp. ',
                ),
                color: secondaryColor,
                type: 'l1',
              ),
            )
          ],
        ),
      ),
    );
  }
}
