import 'package:flutter/material.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';

class ModalAddItemWidget extends StatefulWidget {
  const ModalAddItemWidget({Key? key}) : super(key: key);

  @override
  State<ModalAddItemWidget> createState() => _ModalAddItemWidgetState();
}

class _ModalAddItemWidgetState extends State<ModalAddItemWidget> {
  TextEditingController typeController = TextEditingController(),
      jenisController = TextEditingController(),
      volumeController = TextEditingController();

  int selectedItem = 1000;
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
                  _showModalSelect();
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
                  _showModalSelect();
                },
              ),
            ),
            InputWidget(
              title: "Volume",
              hintText: "Volume",
              controller: volumeController,
              onPress: () async {
                _showModalSelect();
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: ButtonWidget(
                label: "Tambah Data",
                onPressed: () {
                  // if (!loading) {
                  //   requestSending();
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

  _showModalSelect() {
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
          data: jenisSampah,
          selected: selectedItem,
          title: "Jenis Sampah",
          callback: (index, data) {
            setState(() {
              selectedItem = index;
              typeController.text = data['label'];
            });
          },
        );
      },
    );
  }
}
