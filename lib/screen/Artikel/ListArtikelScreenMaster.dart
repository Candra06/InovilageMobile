import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/CardArtikelWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class ListArtikelScreenMaster extends StatefulWidget {
  const ListArtikelScreenMaster({Key? key}) : super(key: key);

  @override
  State<ListArtikelScreenMaster> createState() =>
      _ListArtikelScreenMasterState();
}

class _ListArtikelScreenMasterState extends State<ListArtikelScreenMaster> {
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

  String result = '';
  TextEditingController txtJudul = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: defaultMargin,
              ),
              child: Consumer<ArtikelProvider>(
                builder: (context, data, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderWidget(
                        title: "List Artikel",
                      ),
                      SizedBox(
                        height: defaultMargin,
                      ),
                      buttonAdd(),
                      Consumer<ArtikelProvider>(
                        builder: (context, data, child) {
                          String valueSearch = keyWord.toLowerCase();

                          List dataArtikel = data.listArtikel.where(
                            (item) {
                              if (item.judul!
                                  .toLowerCase()
                                  .contains(valueSearch)) {
                                return true;
                              }
                              return false;
                            },
                          ).toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: defaultMargin,
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
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: dataArtikel.length,
                                itemBuilder: (context, index) {
                                  print(dataArtikel.length);
                                  Map item = dataArtikel[index].toJson();
                                  return CardArtikelWidget(
                                    title: item['judul'],
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Navigation.formArtikelScreen,
                                        arguments: {
                                          "typepage": "edit",
                                          "data": item,
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
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
          Navigation.formArtikelScreen,
          arguments: {
            "typepage": "add",
          },
        );
      },
      child: Container(
        width: 170,
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
              Icons.person_add,
              color: whiteColor,
            ),
            const SizedBox(
              width: 4,
            ),
            TextWidget(
              label: "Tambah Artikel",
              color: whiteColor,
              weight: 'bold',
            )
          ],
        ),
      ),
    );
  }
}
