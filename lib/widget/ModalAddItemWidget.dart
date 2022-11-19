import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/provider/SampahProvider.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';
import 'package:provider/provider.dart';

class ModalAddItemWidget extends StatefulWidget {
  const ModalAddItemWidget({Key? key}) : super(key: key);

  @override
  State<ModalAddItemWidget> createState() => _ModalAddItemWidgetState();
}

class _ModalAddItemWidgetState extends State<ModalAddItemWidget> {
  TextEditingController typeController = TextEditingController(),
      jenisController = TextEditingController(),
      volumeController = TextEditingController();
  List<Map<String, dynamic>> organik = [], anorganik = [];
  Map<String, dynamic> selected = {};
  getListTrash() async {
    var tmpOrganik = Provider.of<SampahProvider>(
      context,
      listen: false,
    ).listOrganik;
    var tmpAnorganik = Provider.of<SampahProvider>(
      context,
      listen: false,
    ).listAnorganik;
    for (var element in tmpOrganik) {
      var tmpData = {
        "label": element.nama,
        "jenis": element.jenis,
        "id": element.id,
        "harga": element.harga,
        "satuan": element.satuan,
      };
      organik.add(tmpData);
    }
    for (var element in tmpAnorganik) {
      var tmpData = {
        "label": element.nama,
        "jenis": element.jenis,
        "id": element.id,
        "harga": element.harga,
        "satuan": element.satuan,
      };
      anorganik.add(tmpData);
    }
  }

  addItem() async {
    selected['subtotal'] = double.parse(selected['harga'].toString()) *
        double.parse(volumeController.text.toString());
    selected['volume'] = volumeController.text;
    Provider.of<PengirimanProvider>(
      context,
      listen: false,
    )
        .addItemTrash(
      item: selected,
    )
        .then((value) {
      if (value) {
        Navigator.pop(context);
      } else {}
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getListTrash();
    });
    super.initState();
  }

  int selectedItem = 1000, selectedJenis = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          vertical: defaultMargin,
        ),
        height: 380,
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
          children: [
            SizedBox(
              width: double.infinity,
              child: InputWidget(
                title: "Jenis Sampah",
                hintText: "Pilih Jenis Sampah",
                controller: typeController,
                iconRight: Icons.keyboard_arrow_down_outlined,
                readOnlyColorCustom: whiteColor,
                readonly: true,
                onPress: () async {
                  _showModalSelect(jenisSampah, "jenis");
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: InputWidget(
                title: "Nama Sampah",
                hintText: "Pilih Nama Sampah",
                controller: jenisController,
                iconRight: Icons.keyboard_arrow_down_outlined,
                readOnlyColorCustom: whiteColor,
                readonly: true,
                onPress: () async {
                  _showModalSelect(
                    typeController.text == 'Organik' ? organik : anorganik,
                    'nama',
                  );
                },
              ),
            ),
            InputWidget(
              title: "Volume",
              hintText: "Volume",
              controller: volumeController,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: ButtonWidget(
                label: "Tambah Data",
                onPressed: () {
                  // Navigator.pop(context);
                  // if (!loading) {
                  addItem();
                  // }
                },
                upperCase: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showModalSelect(List<Map<String, dynamic>> item, String typeSelect) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: whiteColor,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return SelectWidget(
          data: item,
          selected: selectedItem,
          title: "Jenis Sampah",
          callback: (index, data) {
            setState(() {
              if (typeSelect == 'jenis') {
                selectedItem = index;
                typeController.text = data['label'];
              } else {
                selectedItem = index;
                jenisController.text = data['label'];
                selected = data;
              }
            });
          },
        );
      },
    );
  }
}
