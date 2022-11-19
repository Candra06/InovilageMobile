import 'package:flutter/material.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:inovilage/widget/StatusCardWidget.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  getData() async {
    await Provider.of<PengirimanProvider>(
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
              const HeaderWidget(
                title: "List Transaki Pengiriman",
                hideBackPress: true,
              ),
              const SizedBox(
                height: 24,
              ),
              Consumer<PengirimanProvider>(
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
                      return StatusCardWidget(data: item);
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
