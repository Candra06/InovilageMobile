import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/StatusCardWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class LandingUserScreen extends StatefulWidget {
  const LandingUserScreen({Key? key}) : super(key: key);

  @override
  State<LandingUserScreen> createState() => _LandingUserScreenState();
}

class _LandingUserScreenState extends State<LandingUserScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      // loadDashboard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 24,
          ),
          child: Consumer<AuthProvider>(
            builder: (context, value, child) {
              AuthModel user = value.authData!;
              Map dashboard = value.dataDashboard;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: secondaryColor,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            label: "Hai, ${user.name}",
                            weight: 'bold',
                            color: secondaryColor,
                            type: 's1',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextWidget(
                            label: "${user.email}",
                            color: fontSecondaryColor,
                            type: 'l1',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(
                        defaultBorderRadius,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      defaultMargin,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: ImageWidget(
                            image: bgUser,
                          ),
                        ),
                        TextWidget(
                          label:
                              "Ayo kirimkan\nsampahmu melalui\naplikasi XSAMP !",
                          color: whiteColor,
                          weight: "bold",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  TextWidget(
                    label: "Pendapatan",
                    type: 's2',
                    color: secondaryColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: fontSecondaryColor,
                          width: 2,
                        ),
                        top: BorderSide(
                          color: fontSecondaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TextWidget(
                                  label: "Saldo",
                                  color: fontPrimaryColor,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextWidget(
                                  label: value.loading
                                      ? "Memuat..."
                                      : formatrupiah(
                                          amount: dashboard['saldo'].toString(),
                                          awalan: 'Rp. ',
                                        ),
                                  color: fontPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 2,
                              height: 45,
                              child: Column(
                                children: List.generate(
                                  100 ~/ 10,
                                  (index) => Expanded(
                                    child: Container(
                                      color: index % 2 == 0
                                          ? Colors.transparent
                                          : fontSecondaryColor,
                                      height: 8,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextWidget(
                                  textAlign: TextAlign.center,
                                  label: "Total Pick Up",
                                  color: fontPrimaryColor,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextWidget(
                                  label: value.loading
                                      ? "Memuat..."
                                      : dashboard['pickup'].toString(),
                                  color: fontPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultMargin,
                    ),
                    child: TextWidget(
                      label: "Fitur",
                      type: 's2',
                      color: secondaryColor,
                    ),
                  ),
                  AlignedGridView.count(
                    itemCount: features.length,
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      return CardFeature(
                        data: features[index],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultMargin,
                    ),
                    child: TextWidget(
                      label: "Status",
                      type: 's2',
                      color: secondaryColor,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboard['order'].length,
                    itemBuilder: (context, index) {
                      Map item = dashboard['order'][index];
                      return StatusCardWidget(
                        data: item,
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardFeature extends StatelessWidget {
  final Map<String, dynamic> data;
  const CardFeature({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          data['url'],
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: defaultMargin,
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
            data['icon'],
            const SizedBox(
              height: 6,
            ),
            TextWidget(
              label: data['label'],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
