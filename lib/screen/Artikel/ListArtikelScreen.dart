import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inovilage/model/AuthModel.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/CardArtikelWidget.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class ListArtikelScreen extends StatefulWidget {
  const ListArtikelScreen({Key? key}) : super(key: key);

  @override
  State<ListArtikelScreen> createState() => _ListArtikelScreenState();
}

class _ListArtikelScreenState extends State<ListArtikelScreen> {
  TextEditingController searchController = TextEditingController();
  String keyWord = "";
  Timer? _debounce;
  searchInputOnChange(value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
        const Duration(
          milliseconds: 250,
        ), () {
      setState(() {
        keyWord = value;
      });
    });
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
          child: Consumer<ArtikelProvider>(
            builder: (context, data, child) {
              String valueSearch = keyWord.toLowerCase();

              List dataArtikel = data.listArtikel.where(
                (item) {
                  if (item.judul!.toLowerCase().contains(valueSearch)) {
                    return true;
                  }
                  return false;
                },
              ).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Consumer<AuthProvider>(
                        builder: (context, value, child) {
                          AuthModel user = value.authData!;
                          return Column(
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
                                label:
                                    "Ayo cari tau tentang Ekspedisi Sampah (XSAMP) !",
                                color: fontSecondaryColor,
                                type: 'b2',
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                  InputWidget(
                    title: "hidden",
                    hintText: "Cari",
                    background: lightPrimaryColor,
                    border: 'none',
                    iconLeft: Icons.search,
                    onChanged: searchInputOnChange,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextWidget(
                    label: "Informasi untukmu",
                    weight: 'bold',
                    color: secondaryColor,
                    type: 's2',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dataArtikel.length,
                    itemBuilder: (context, index) {
                      Map item = dataArtikel[index];
                      return CardArtikelWidget(
                        title: item['judul'],
                        onPressed: () {},
                      );
                    },
                  ),
                ],
              );
            },
          )),
    ));
  }
}
