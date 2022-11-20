import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/model/DetailPengirimanModel.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/DonasiProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class DetailDonasiScreen extends StatefulWidget {
  final String id;
  const DetailDonasiScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailDonasiScreen> createState() => _DetailDonasiScreenState();
}

class _DetailDonasiScreenState extends State<DetailDonasiScreen> {
  bool loading = false;
  confirmOrder() async {
    setState(() {
      loading = true;
    });
    await Provider.of<DonasiProvider>(
      context,
      listen: false,
    ).confirm(widget.id).then((response) {
      if (response['code'] == '00') {
        showSnackBar(
          context,
          "Success",
          subtitle: response['message'],
          position: 'TOP',
          duration: 4,
          type: 'success',
        );
        Navigator.pushNamed(
          context,
          Navigation.homeScreenAdmin,
          arguments: '1',
        );
        // onPressBottomTop();
      } else {
        showSnackBar(
          context,
          "Gagal",
          subtitle: response['message'],
          position: 'TOP',
          duration: 4,
          type: 'error',
        );
      }
    });
    setState(() {
      loading = false;
    });
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
      body: SafeArea(
        child: Consumer<DonasiProvider>(
          builder: (context, value, child) {
            DetailPengirimanModel data = value.detailDonasi;
            double totalOrganik = 0, totalAnorganik = 0;
            for (var element in data.itemOrganik!) {
              totalOrganik += num.tryParse(element.volume!)!.toDouble();
            }
            for (var element in data.itemAnorganik!) {
              totalAnorganik += num.tryParse(element.volume!)!.toDouble();
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
                        title: "Detail Donasi",
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
                                      BadgeWidget(
                                        text: data.status!,
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
                                                      subtitle: "",
                                                      endTitle:
                                                          "${itemAnorganik.volume!}${itemAnorganik.satuan!}",
                                                    );
                                                  },
                                                ),
                                                cardItem(
                                                  colors: greyCardCOlor,
                                                  title: "Jumlah",
                                                  subtitle: "",
                                                  endTitle:
                                                      "${totalAnorganik.toString()}kg",
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
                                                  itemCount:
                                                      data.itemOrganik!.length,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    Item itemOrganik = data
                                                        .itemOrganik![index];
                                                    return cardItem(
                                                      colors: index % 2 == 1
                                                          ? whiteColor
                                                          : greyCardCOlor,
                                                      title: itemOrganik.nama!,
                                                      subtitle: "",
                                                      endTitle:
                                                          "${itemOrganik.volume!}${itemOrganik.satuan!}",
                                                    );
                                                  },
                                                ),
                                                cardItem(
                                                  colors: greyCardCOlor,
                                                  title: "Jumlah",
                                                  subtitle: "",
                                                  endTitle:
                                                      "${totalOrganik.toString()}kg",
                                                ),
                                                SizedBox(
                                                  height: defaultMargin,
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      authData.role != 'Kurir'
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                top: defaultMargin,
                                              ),
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
                      ),
                      authData.role == 'Admin' && data.status == 'Proses'
                          ? ButtonWidget(
                              label: "Setujui",
                              isLoading: loading,
                              theme: loading ? 'disable' : 'primary',
                              onPressed: () {
                                if (!loading) {
                                  confirmOrder();
                                }
                              },
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
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
