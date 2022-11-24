import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({Key? key}) : super(key: key);

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  String typePage = "Pengguna", keyWord = "";
  Timer? _debounce;
  getPage() {
    var args = ModalRoute.of(context)!.settings.arguments as String;
    if (args.isNotEmpty) {
      setState(() {
        typePage = args;
      });
    }
  }

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
  void initState() {
    Future.delayed(Duration.zero, () {
      getPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                title: typePage == "Pengguna"
                    ? "Edit Data User"
                    : "Edit Data Kurir",
              ),
              SizedBox(
                height: defaultMargin,
              ),
              buttonAdd(),
              SizedBox(
                height: defaultMargin,
              ),
              InputWidget(
                title: "hidden",
                hintText: "Cari nama",
                background: lightPrimaryColor,
                border: 'none',
                iconLeft: Icons.search,
                onChanged: searchInputOnChange,
              ),
              Expanded(
                child: SingleChildScrollView(child: Consumer<AuthProvider>(
                  builder: (context, data, child) {
                    List dataUser = [];
                    if (typePage == 'Pengguna') {
                      dataUser = data.listPengguna.where(
                        (item) {
                          if (item.name!.toLowerCase().contains(keyWord)) {
                            return true;
                          }
                          return false;
                        },
                      ).toList();
                    } else {
                      dataUser = data.listKurir.where(
                        (item) {
                          if (item.name!.toLowerCase().contains(keyWord)) {
                            return true;
                          }
                          return false;
                        },
                      ).toList();
                    }
                    return Container(
                      margin: EdgeInsets.only(
                        top: defaultMargin,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataUser.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Map item = dataUser[index].toJson();
                            return listItem(item);
                          }),
                    );
                  },
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(Map data) {
    return GestureDetector(
      onTap: () {
        Map args = {
          "typepage": typePage,
          "data": data,
        };
        Navigator.pushNamed(
          context,
          Navigation.formUsersScreen,
          arguments: args,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              defaultBorderRadius,
            ),
          ),
        ),
        padding: EdgeInsets.all(
          defaultMargin / 2,
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 40,
              color: primaryColor,
            ),
            SizedBox(
              width: defaultMargin / 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  label: data['name'],
                  type: 'b2',
                  color: secondaryColor,
                  weight: 'medium',
                ),
                TextWidget(
                  label: data['alamat'],
                  type: 'l1',
                  color: secondaryColor,
                  weight: 'normal',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buttonAdd() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Navigation.formUsersScreen,
          arguments: {
            "typepage": typePage,
          },
        );
      },
      child: Container(
        width: typePage == "Pengguna" ? 200 : 160,
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
              label:
                  typePage == "Pengguna" ? "Tambah Pengguna" : "Tambah Kurir",
              color: whiteColor,
              weight: 'bold',
            )
          ],
        ),
      ),
    );
  }
}
