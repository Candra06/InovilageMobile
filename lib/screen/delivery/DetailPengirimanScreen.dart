import 'package:flutter/material.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/BadgeWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/TextWidget.dart';

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              TextWidget(
                                label: "Jumlah Sampah Anorganik",
                                color: secondaryColor,
                                type: 'b1',
                              ),
                              SizedBox(
                                height: defaultMargin,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 4,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return cardItem(
                                    colors: index % 2 == 1
                                        ? whiteColor
                                        : greyCardCOlor,
                                    title: "Botol Kaca",
                                    subtitle: "1.5kg x 3000/kg",
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
                              TextWidget(
                                label: "Jumlah Sampah Organik",
                                color: secondaryColor,
                                type: 'b1',
                              ),
                              SizedBox(
                                height: defaultMargin,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 3,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return cardItem(
                                    colors: index % 2 == 1
                                        ? whiteColor
                                        : greyCardCOlor,
                                    title: "Botol Kaca",
                                    subtitle: "1.5kg x 3000/kg",
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
                              TextWidget(
                                label: "Pendapatan Kurir",
                                color: secondaryColor,
                                type: 'b1',
                              ),
                              cardItem(
                                colors: greyCardCOlor,
                                title: "10% x 25000",
                                subtitle: "",
                                endTitle: "4500",
                              ),
                              Container(
                                width: double.infinity,
                                child: TextWidget(
                                  label: "Kurir : kurir",
                                  color: secondaryColor,
                                  type: 'b1',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
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
