// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/DonasiProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:inovilage/widget/StatusCardWidget.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  final String type;
  const TransactionScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  getData() async {
    await Provider.of<PengirimanProvider>(
      context,
      listen: false,
    ).getListPengiriman();
    await Provider.of<DonasiProvider>(
      context,
      listen: false,
    ).getListPengiriman();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          defaultMargin,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.authData!.role == 'Pengguna') {
                    return const HeaderWidget(
                      title: "List Transaki Pengiriman",
                      hideBackPress: false,
                    );
                  } else {
                    return HeaderWidget(
                      title: widget.type == 'pengiriman'
                          ? "List Transaki Pengiriman"
                          : "List Transaksi Donasi",
                      hideBackPress: true,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              widget.type == 'pengiriman'
                  ? Consumer<PengirimanProvider>(
                      builder: (context, value, child) {
                        if (value.loadingList) {
                          return const Center(
                            child: LoadingWidget(),
                          );
                        }
                        return ListView.builder(
                          itemCount: value.listPengiriman.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map item = value.listPengiriman[index].toJson();
                            return StatusCardWidget(
                              data: item,
                            );
                          },
                        );
                      },
                    )
                  : Consumer<DonasiProvider>(
                      builder: (context, value, child) {
                        if (value.loadingList) {
                          return const Center(
                            child: LoadingWidget(),
                          );
                        }
                        return ListView.builder(
                          itemCount: value.listDonasi.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map item = value.listDonasi[index].toJson();
                            return StatusCardWidget(
                              data: item,
                              transType: 'donasi',
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
