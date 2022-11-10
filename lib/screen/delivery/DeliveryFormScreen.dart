import 'package:flutter/material.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class DeliveryFormScreen extends StatefulWidget {
  const DeliveryFormScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryFormScreen> createState() => _DeliveryFormScreenState();
}

class _DeliveryFormScreenState extends State<DeliveryFormScreen> {
  TextEditingController nameController = TextEditingController(),
      phoneController = TextEditingController(),
      addressController = TextEditingController(),
      dateController = TextEditingController(),
      typeController = TextEditingController();
  DateTime date = DateTime.now();
  DateTime now = DateTime.now();
  int selectedItem = 1000;
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
            children: [
              const HeaderWidget(
                title: "Ajukan Pengiriman Sampah",
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "Nama Pengirim",
                  hintText: "Nama Lengkap",
                  controller: nameController,
                  iconLeft: Icons.account_circle_outlined,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: InputWidget(
                  title: "No HP",
                  hintText: "Nomor Telepon",
                  controller: phoneController,
                  iconLeft: Icons.phone_android,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: 4,
                  top: defaultMargin,
                ),
                child: TextWidget(
                  label: "Alamat",
                  type: 'l1',
                  color: fontSecondaryColor,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 300,
                child: OpenStreetMapSearchAndPick(
                  center: LatLong(-7.9131449, 113.816263),
                  buttonColor: primaryColor,
                  buttonText: 'Pilih Lokasi',
                  onPicked: (pickedData) {
                    addressController.text = pickedData.address;
                    print(pickedData.latLong.latitude);
                    print(pickedData.latLong.longitude);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: InputWidget(
                  title: "Tanggal",
                  hintText: "Pilih Tanggal",
                  controller: dateController,
                  iconRight: Icons.keyboard_arrow_down_outlined,
                  readOnlyColorCustom: whiteColor,
                  readonly: true,
                  onPress: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(now.year, now.month, now.day),
                      lastDate: DateTime(2100),
                    );
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                      dateController.text = dateFormatDay(
                        context,
                        format: "E, dd MMM y",
                        value: newDate.toString(),
                      );
                    });
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: InputWidget(
                  title: "Tanggal",
                  hintText: "Pilih Tanggal",
                  controller: typeController,
                  iconRight: Icons.keyboard_arrow_down_outlined,
                  readOnlyColorCustom: whiteColor,
                  readonly: true,
                  onPress: () async {
                    _showModalSelect();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                ),
                child: ButtonWidget(
                  label: "Ajukan Pengiriman Sampah",
                  onPressed: () {},
                  upperCase: false,
                ),
              ),
            ],
          ),
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
