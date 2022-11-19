import 'package:flutter/material.dart';
import 'package:inovilage/provider/SampahProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';
import 'package:provider/provider.dart';

class FormTrashScreen extends StatefulWidget {
  const FormTrashScreen({Key? key}) : super(key: key);

  @override
  State<FormTrashScreen> createState() => _FormTrashScreenState();
}

class _FormTrashScreenState extends State<FormTrashScreen> {
  String method = "add", id = "", latitude = "", longitude = "";
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      satuanController = TextEditingController(),
      harga = TextEditingController(),
      typeController = TextEditingController();

  int selectedItem = 0;

  void onSubmit() {
    if (nameController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Nama Lengkap wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (satuanController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Nomor telepon wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (harga.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Nomor telepon wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else {
      if (method == 'add') {
        register();
      } else {
        update();
      }
    }
  }

  register() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> body = {
      "jenis": typeController.text,
      "nama": nameController.text,
      "satuan": satuanController.text,
      "harga": harga.text,
    };

    await Provider.of<SampahProvider>(
      context,
      listen: false,
    )
        .createTrashData(
      body,
    )
        .then((value) async {
      if (value['code'] == '00') {
        await Provider.of<SampahProvider>(
          context,
          listen: false,
        ).getListTrash().then((request) {
          if (request['code'] == '00') {
            showSnackBar(
              context,
              "Success",
              subtitle: value['message'],
              type: "success",
              duration: 5,
              position: 'top',
            );
            Navigator.pop(context);
          }
        });
      } else {
        showSnackBar(
          context,
          "Failed",
          subtitle: value['message'],
          type: "error",
          duration: 5,
          position: 'top',
        );
      }
    });
    setState(() {
      loading = false;
    });
  }

  update() async {
    setState(() {
      loading = true;
    });

    Map<String, dynamic> body = {
      "jenis": typeController.text,
      "nama": nameController.text,
      "satuan": satuanController.text,
      "harga": harga.text,
    };

    await Provider.of<SampahProvider>(
      context,
      listen: false,
    )
        .editTrashData(
      body,
      id,
    )
        .then((value) async {
      if (value['code'] == '00') {
        Provider.of<SampahProvider>(context, listen: false)
            .getListTrash()
            .then((request) {
          if (request['code'] == '00') {
            showSnackBar(
              context,
              "Success",
              subtitle: value['message'],
              type: "success",
              duration: 5,
              position: 'top',
            );
            Navigator.pop(context);
          }
        });
      } else {
        showSnackBar(
          context,
          "Failed",
          subtitle: value['message'],
          type: "error",
          duration: 5,
          position: 'top',
        );
      }
    });
    setState(() {
      loading = false;
    });
  }

  getPage() {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args.isNotEmpty) {
      if (args['data'] != null) {
        Map data = args['data'];

        nameController.text = data['nama'];
        satuanController.text = data['satuan'];
        harga.text = data['harga'];
        id = data['id'].toString();
        selectedItem = data['jenis'] == 'Organik' ? 1 : 0;
        typeController.text = data['jenis'];
        method = 'edit';
      }
      setState(() {});
    }
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
                title:
                    method == 'add' ? "Tambah Data Sampah" : "Edit Data Sampah",
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Nama Sampah",
                  controller: nameController,
                  iconLeft: Icons.delete,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Harga Satuan",
                  controller: harga,
                  iconLeft: Icons.price_change,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Satuan",
                  maxChar: 255,
                  controller: satuanController,
                  iconLeft: Icons.list,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: defaultMargin,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: InputWidget(
                    title: "hidden",
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
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  isLoading: loading,
                  theme: loading ? 'disable' : 'primary',
                  label: method == "add" ? "Tambah Data" : "Perbarui Data",
                  onPressed: () {
                    if (!loading) {
                      onSubmit();
                    }
                  },
                  upperCase: true,
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
