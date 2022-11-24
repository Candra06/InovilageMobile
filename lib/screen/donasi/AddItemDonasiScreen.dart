// ignore_for_file: use_build_context_synchronously, await_only_futures

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/model/DetailPengirimanModel.dart';
import 'package:inovilage/provider/DonasiProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/ModalAddItemWidget.dart';
import 'package:inovilage/widget/ModalOptionWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AddItemDonasiScreen extends StatefulWidget {
  final String id;
  const AddItemDonasiScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AddItemDonasiScreen> createState() => _AddItemDonasiScreenState();
}

class _AddItemDonasiScreenState extends State<AddItemDonasiScreen> {
  double lat = -8.339147, long = 113.5814033;
  bool loading = false;
  getDetail() async {
    Provider.of<DonasiProvider>(
      context,
      listen: false,
    ).getDetailPengiriman(
      widget.id,
    );
  }

  onPressBottomTop() async {
    Provider.of<DonasiProvider>(
      context,
      listen: false,
    ).addItemTrash(
      item: {},
      isReset: true,
    ).then((value) => Navigator.pushReplacementNamed(
          context,
          Navigation.homeScreenAdmin,
        ));
  }

  onPressButtonBottom() async {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ModalOptionWidget(
              title: "Konfirmasi",
              subtitle:
                  "Apakah anda yakin ingin menutup halaman ini dan membatalkan perubahan?",
              titleButtonTop: 'Iya',
              titleButtonBottom: 'Kembali',
              onPressButtonTop: onPressBottomTop,
              onPressButtonBottom: onPressButtonBottom,
              imageTopHeight: 125,
              textAlign: TextAlign.center,
              axisText: CrossAxisAlignment.center,
              alignmentText: Alignment.center,
            );
          },
        )) ??
        false;
  }

  Future<void> _launchUrl(String latitude, String longitude) async {
    String uri =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (!await launchUrl(
      Uri.parse(uri),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }

  onSubmit() async {
    setState(() {
      loading = true;
    });
    var tmpItem = await Provider.of<DonasiProvider>(
      context,
      listen: false,
    ).listItem;
    if (tmpItem.isEmpty) {
      showSnackBar(
        context,
        "Info",
        subtitle: "Belum ada item ditambahkan",
        position: 'TOP',
        duration: 4,
        type: 'warning',
      );
    } else {
      List tmpId = [], tmpVolume = [];
      for (var element in tmpItem) {
        tmpId.add(element['id']);
        tmpVolume.add(element['volume']);
      }
      Map<String, dynamic> body = {
        "sampah_id": tmpId.join(","),
        "volume": tmpVolume.join(","),
      };
      await Provider.of<DonasiProvider>(
        context,
        listen: false,
      ).addItemPengiriman(body, widget.id).then((response) {
        if (response['code'] == '00') {
          showSnackBar(
            context,
            "Success",
            subtitle: response['message'],
            position: 'TOP',
            duration: 4,
            type: 'success',
          );
          onPressBottomTop();
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
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getDetail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Consumer<DonasiProvider>(
            builder: (context, value, child) {
              DetailPengirimanModel detail = value.detailDonasi;

              return Padding(
                padding: EdgeInsets.all(defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(
                      title: "Detail Donasi",
                      onPressBack: onWillPop,
                    ),
                    SizedBox(
                      height: defaultMargin,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              label: "#${detail.kodeTransaksi}",
                                              color: fontPrimaryColor,
                                              type: 'l1',
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4,
                                              ),
                                              child: TextWidget(
                                                label: detail.alamatJemput!,
                                                color: fontPrimaryColor,
                                                maxLines: 2,
                                                useEllipsis: true,
                                                type: 'l1',
                                              ),
                                            ),
                                          ],
                                        ),
                                        BadgeWidget(
                                          text: detail.status!,
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
                                  Padding(
                                    padding: EdgeInsets.all(
                                      defaultMargin,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              label: "Tanggal : ${dateFormatDay(
                                                context,
                                                format: "dd MMMM yyy hh:mm",
                                                value: detail.createdAt!
                                                    .toString(),
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
                                                    "Jenis : ${detail.jenisSampah}",
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: defaultMargin,
                            ),
                            TextWidget(
                              label: "Alamat",
                              color: secondaryColor,
                              type: 'b1',
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: OpenStreetMapSearchAndPick(
                                center: LatLong(
                                  double.parse(detail.latAddress.toString()),
                                  double.parse(detail.longAddress.toString()),
                                ),
                                buttonColor: primaryColor,
                                buttonText: 'Buka di Maps',
                                onPicked: (pickedData) async {
                                  await _launchUrl(
                                    detail.latAddress.toString(),
                                    detail.longAddress.toString(),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: defaultMargin,
                            ),
                            previewItem(),
                            SizedBox(
                              height: defaultMargin,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ButtonWidget(
                      label: "Pick Up dan Kirim",
                      isLoading: loading,
                      theme: loading ? 'disable' : 'primary',
                      onPressed: () {
                        if (!loading) {
                          onSubmit();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget previewItem() {
    return Consumer<DonasiProvider>(
      builder: (context, data, child) {
        List organik = data.listItem.where(
          (item) {
            if (item['jenis'] == 'Organik') {
              return true;
            }
            return false;
          },
        ).toList();

        List anorganik = data.listItem.where(
          (item) {
            if (item['jenis'] == 'Anorganik') {
              return true;
            }
            return false;
          },
        ).toList();

        return Container(
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
          // padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buttonAdd(),
              Divider(
                thickness: 2,
                color: primaryColor,
              ),
              data.totalAnorganik['volume'] != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: TextWidget(
                            label: "Jumlah Sampah Anorganik",
                            color: secondaryColor,
                            type: 'b1',
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(
                            top: defaultMargin,
                            left: defaultMargin,
                            right: defaultMargin,
                          ),
                          shrinkWrap: true,
                          itemCount: anorganik.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return cardItem(
                              colors:
                                  index % 2 == 1 ? whiteColor : greyCardCOlor,
                              title: anorganik[index]['label'],
                              subtitle: "",
                              endTitle:
                                  "${anorganik[index]['volume']}${anorganik[index]['satuan']}",
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: cardItem(
                            colors: greyCardCOlor,
                            title: "Jumlah",
                            subtitle: "",
                            endTitle: "${data.totalAnorganik['volume']}kg",
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                      ],
                    )
                  : const SizedBox(),
              data.totalOrganik['volume'] != 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: TextWidget(
                            label: "Jumlah Sampah Organik",
                            color: secondaryColor,
                            type: 'b1',
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(
                            top: defaultMargin,
                            left: defaultMargin,
                            right: defaultMargin,
                          ),
                          shrinkWrap: true,
                          itemCount: organik.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return cardItem(
                              colors:
                                  index % 2 == 1 ? whiteColor : greyCardCOlor,
                              title: organik[index]['label'],
                              subtitle: "",
                              endTitle:
                                  "${organik[index]['volume']}${organik[index]['satuan']} ",
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultMargin,
                          ),
                          child: cardItem(
                            colors: greyCardCOlor,
                            title: "Jumlah",
                            subtitle: "",
                            endTitle: "${data.totalOrganik['volume']}kg",
                          ),
                        ),
                        SizedBox(
                          height: defaultMargin,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
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

  Widget buttonAdd() {
    return GestureDetector(
      onTap: () {
        showAddItemDialog('1');
      },
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.all(
          defaultMargin,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              defaultBorderRadius,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: TextWidget(
          label: "Tambah Data",
          color: whiteColor,
        ),
      ),
    );
  }

  showAddItemDialog(String id) {
    return showDialog<void>(
      context: context,

      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return const ModalAddItemWidget(
          type: 'donasi',
        );
      },
    );
  }
}
