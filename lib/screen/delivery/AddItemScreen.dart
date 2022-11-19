import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/ModalAddItemWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class AddItemScreen extends StatefulWidget {
  final String id;
  const AddItemScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  double lat = -8.339147, long = 113.5814033;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
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
                                        label: "#TP20012881293",
                                        color: fontPrimaryColor,
                                        type: 'l1',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: TextWidget(
                                          label: "Rumah Makan Waluyo",
                                          color: fontPrimaryColor,
                                          maxLines: 2,
                                          useEllipsis: true,
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
                            Padding(
                              padding: EdgeInsets.all(
                                defaultMargin,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        label: "Tanggal : ${dateFormatDay(
                                          context,
                                          format: "dd MMMM yyy hh:mm",
                                          value: '2022-11-09 15:10:27',
                                        )}",
                                        color: fontPrimaryColor,
                                        type: 'l1',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: TextWidget(
                                          label: "Jenis : Organik",
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
                          center: LatLong(lat, long),
                          buttonColor: primaryColor,
                          buttonText: 'Pilih Lokasi',
                          onPicked: (pickedData) {},
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget previewItem() {
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
          Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: TextWidget(
              label: "Jumlah Sampah Anorganik",
              color: secondaryColor,
              type: 'b1',
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
            ),
            shrinkWrap: true,
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return cardItem(
                colors: index % 2 == 1 ? whiteColor : greyCardCOlor,
                title: "Botol Kaca",
                subtitle: "1.5kg x 3000/kg",
                endTitle: "4500",
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
              subtitle: "4.5kg",
              endTitle: "4500",
            ),
          ),
          SizedBox(
            height: defaultMargin,
          ),
          Padding(
            padding: EdgeInsets.all(defaultMargin),
            child: TextWidget(
              label: "Jumlah Sampah Anorganik",
              color: secondaryColor,
              type: 'b1',
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.only(
              left: defaultMargin,
              right: defaultMargin,
            ),
            shrinkWrap: true,
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return cardItem(
                colors: index % 2 == 1 ? whiteColor : greyCardCOlor,
                title: "Botol Kaca",
                subtitle: "1.5kg x 3000/kg",
                endTitle: "4500",
              );
            },
          ),
          SizedBox(
            height: defaultMargin,
          ),
        ],
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
        return ModalAddItemWidget();
      },
    );
  }
}
