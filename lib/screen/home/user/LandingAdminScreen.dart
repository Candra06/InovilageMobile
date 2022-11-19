import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/StatusCardWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class LandingAdminScreen extends StatefulWidget {
  const LandingAdminScreen({Key? key}) : super(key: key);

  @override
  State<LandingAdminScreen> createState() => _LandingAdminScreenState();
}

class _LandingAdminScreenState extends State<LandingAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 24,
            ),
            child: Consumer<AuthProvider>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_circle_outlined,
                              color: secondaryColor,
                              size: 40,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  label: "Hai, ${value.authData!.name!}",
                                  weight: 'bold',
                                  color: secondaryColor,
                                  type: 's1',
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextWidget(
                                  label: "Hai, ${value.authData!.email!}",
                                  color: fontSecondaryColor,
                                  type: 'l1',
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.logout,
                          color: secondaryColor,
                          size: 40,
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
                              image: bgAdmin,
                            ),
                          ),
                          TextWidget(
                            label:
                                "Kelola aplikasi \n dengan sistem\n yang cerdas",
                            color: whiteColor,
                            weight: "bold",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: defaultMargin,
                      ),
                      child: TextWidget(
                        label: "Setting",
                        type: 's2',
                        color: secondaryColor,
                      ),
                    ),
                    AlignedGridView.count(
                      itemCount: featuresAdmin.length,
                      shrinkWrap: true,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      itemBuilder: (context, index) {
                        return CardFeature(
                          data: featuresAdmin[index],
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: defaultMargin,
                      ),
                      child: TextWidget(
                        label: "Order",
                        type: 's2',
                        color: secondaryColor,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.dataDashboard['order'].length,
                      itemBuilder: (context, index) {
                        Map item = value.dataDashboard['order'][index];
                        return StatusCardWidget(
                          data: item,
                        );
                      },
                    )
                  ],
                );
              },
            )),
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
          arguments: data['arguments'],
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: backGroundFeature,
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: -1,
              blurRadius: 3,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            data['icon'],
            const SizedBox(
              height: 6,
            ),
            TextWidget(
              label: data['label'],
              type: 'b2',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
