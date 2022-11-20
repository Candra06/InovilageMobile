// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/model/SaldoModel.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/SaldoProvider.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:inovilage/widget/ModalOptionWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class ListHistorySaldoScreen extends StatefulWidget {
  const ListHistorySaldoScreen({Key? key}) : super(key: key);

  @override
  State<ListHistorySaldoScreen> createState() => _ListHistorySaldoScreenState();
}

class _ListHistorySaldoScreenState extends State<ListHistorySaldoScreen> {
  getSaldo() async {
    await Provider.of<SaldoProvider>(
      context,
      listen: false,
    ).getListSaldo();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getSaldo();
    });
    super.initState();
  }

  Future<bool> onWillPop() async {
    var auth = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).authData;
    if (auth!.role == 'Pengguna') {
      Navigator.pushNamed(
        context,
        Navigation.homeScreen,
        arguments: '2',
      );
    } else {
      Navigator.pushNamed(
        context,
        Navigation.homeScreenAdmin,
        arguments: '3',
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(
                defaultMargin,
              ),
              height: MediaQuery.of(context).size.height,
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        title: "Riwayat Saldo",
                        onPressBack: onWillPop,
                      ),
                      value.authData!.role == 'Admin'
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: defaultMargin,
                              ),
                              child: buttonAdd(),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: defaultMargin,
                      ),
                      //  Consumer<Saldo>(builder: builder)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Consumer<SaldoProvider>(
                            builder: (context, data, child) {
                              if (data.loading) {
                                return const LoadingWidget();
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.listSaldo.length,
                                itemBuilder: (context, index) {
                                  SaldoModel item = data.listSaldo[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 8.0,
                                    ),
                                    child: Card(
                                      child: Container(
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
                                                  label: formatrupiah(
                                                    amount: item.jumlahTransaksi
                                                        .toString(),
                                                    awalan: 'Rp. ',
                                                  ),
                                                  type: 'b1',
                                                  weight: 'bold',
                                                ),
                                                SizedBox(
                                                  height: defaultMargin / 2,
                                                ),
                                                value.authData!.role == 'Admin'
                                                    ? TextWidget(
                                                        label: item.name!,
                                                        type: 'b3',
                                                        weight: 'medium',
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(
                                                  height: defaultMargin / 2,
                                                ),
                                                TextWidget(
                                                  label: dateFormatDay(
                                                    context,
                                                    format: "dd MMMM yyy hh:mm",
                                                    value: item.createdAt
                                                        .toString(),
                                                  ),
                                                  type: 'l1',
                                                  weight: 'normal',
                                                ),
                                              ],
                                            ),
                                            item.jenis == 'Debit'
                                                ? Icon(
                                                    Icons.arrow_circle_down,
                                                    color: greenColor,
                                                    size: defaultMargin * 2,
                                                  )
                                                : Icon(
                                                    Icons.arrow_circle_up,
                                                    color: redColor,
                                                    size: defaultMargin * 2,
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  Widget buttonAdd() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Navigation.formWtihdrawScreen,
          arguments: 'add',
        );
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              defaultBorderRadius,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add_box_rounded,
              color: whiteColor,
            ),
            const SizedBox(
              width: 4,
            ),
            TextWidget(
              label: "Penarikan Saldo",
              color: whiteColor,
              weight: 'bold',
            )
          ],
        ),
      ),
    );
  }
}
