import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/DonasiProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:inovilage/widget/StatusCardWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class ListDonasiScreen extends StatefulWidget {
  const ListDonasiScreen({Key? key}) : super(key: key);

  @override
  State<ListDonasiScreen> createState() => _ListDonasiScreenState();
}

class _ListDonasiScreenState extends State<ListDonasiScreen> {
  getData() async {
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
              const HeaderWidget(
                title: "List Transaki Donasi",
                hideBackPress: false,
              ),
              const SizedBox(
                height: 24,
              ),
              buttonAdd(),
              SizedBox(
                height: defaultMargin,
              ),
              Consumer<DonasiProvider>(
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

  Widget buttonAdd() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Navigation.formDonasiScreen,
          arguments: {
            "typepage": "add",
          },
        );
      },
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(10),
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
          label: "Ajukan Donasi",
          color: whiteColor,
          weight: 'medium',
        ),
      ),
    );
  }
}
