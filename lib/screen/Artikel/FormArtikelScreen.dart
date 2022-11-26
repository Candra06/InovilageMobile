// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/Static.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';
import 'package:provider/provider.dart';

class FormArtikelScreen extends StatefulWidget {
  const FormArtikelScreen({Key? key}) : super(key: key);

  @override
  State<FormArtikelScreen> createState() => _FormArtikelScreenState();
}

class _FormArtikelScreenState extends State<FormArtikelScreen> {
  TextEditingController titleController = TextEditingController(),
      statusController = TextEditingController();

  final HtmlEditorController controller = HtmlEditorController();
  bool loading = false;
  String typePage = "add", konten = "";
  int selectedItem = 3;
  getData() async {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args.isNotEmpty) {
      if (args['typepage'] == 'edit') {
        setState(() {
          titleController.text = "Loading ...";
          statusController.text = "Loading ...";
        });
        Provider.of<ArtikelProvider>(
          context,
          listen: false,
        ).getDetailArtikel(args['data']['id'].toString()).then((data) {
          if (data['code'] == '00') {
            var item = data['data'];
            print(item['konten']);
            setState(() {
              titleController.text = item['judul'];
              statusController.text = item['status'];
              konten = item['konten'];
              typePage = 'edit';
            });
          } else {
            showSnackBar(
              context,
              'Failed',
              subtitle: data['message'],
              type: 'error',
              position: 'TOP',
              duration: 3,
            );
          }
        });
      }
    }

    setState(() {});
  }

  onSubmit() async {
    setState(() {
      loading = true;
    });
    if (titleController.text.isEmpty) {
      showSnackBar(
        context,
        'Warning',
        subtitle: 'Judul tidak boleh kosong',
        type: 'warning',
        position: 'TOP',
        duration: 2,
      );
    } else if (statusController.text.isEmpty) {
      showSnackBar(
        context,
        'Warning',
        subtitle: 'Status tidak boleh kosong',
        type: 'warning',
        position: 'TOP',
        duration: 2,
      );
    } else if (controller.getText().toString().isEmpty) {
      showSnackBar(
        context,
        'Warning',
        subtitle: 'Konten tidak boleh kosong',
        type: 'warning',
        position: 'TOP',
        duration: 2,
      );
    } else {
      if (typePage == 'add') {
        addData();
      } else {
        editData();
      }
    }
    setState(() {
      loading = false;
    });
  }

  editData() async {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    setState(() {
      loading = true;
    });
    Map<String, dynamic> body = {
      "judul": titleController.text,
      "konten": await controller.getText(),
      "status": statusController.text,
    };

    Provider.of<ArtikelProvider>(
      context,
      listen: false,
    )
        .editArtikel(
      id: args['data']['id'].toString(),
      body: body,
    )
        .then((respponse) async {
      if (respponse['code'] == '00') {
        await Provider.of<ArtikelProvider>(
          context,
          listen: false,
        ).getArtikelList().then((request) {
          if (request['code'] == '00') {
            showSnackBar(
              context,
              "Success",
              subtitle: respponse['message'],
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
          subtitle: respponse['message'],
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

  addData() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> body = {
      "judul": titleController.text,
      "konten": await controller.getText(),
      "status": statusController.text,
    };
    Provider.of<ArtikelProvider>(
      context,
      listen: false,
    )
        .postArtikel(
      body: body,
    )
        .then((respponse) async {
      if (respponse['code'] == '00') {
        await Provider.of<ArtikelProvider>(
          context,
          listen: false,
        ).getArtikelList().then((request) {
          if (request['code'] == '00') {
            showSnackBar(
              context,
              "Success",
              subtitle: respponse['message'],
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
          subtitle: respponse['message'],
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          child: Column(
            children: <Widget>[
              HeaderWidget(
                title: typePage == 'add' ? "Tambah Artikel" : "Edit Artikel",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: defaultMargin,
                    ),
                    child: InputWidget(
                      title: "Judul Artikel",
                      hintText: "Judul Artikel",
                      controller: titleController,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      bottom: defaultMargin,
                    ),
                    child: InputWidget(
                      title: "Status",
                      hintText: "Status",
                      controller: statusController,
                      iconRight: Icons.keyboard_arrow_down_outlined,
                      readOnlyColorCustom: whiteColor,
                      readonly: true,
                      onPress: () async {
                        _showModalSelect(statusArtikel);
                      },
                    ),
                  ),
                  HtmlEditor(
                    controller: controller,
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: 'Your text here...',
                      shouldEnsureVisible: false,
                      initialText: konten,
                    ),
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.aboveEditor, //by default
                      toolbarType: ToolbarType.nativeGrid, //by default
                    ),
                    otherOptions: const OtherOptions(height: 550),
                  ),
                ],
              ),
              SizedBox(
                height: defaultMargin,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  label: "Simpan",
                  isLoading: loading,
                  theme: loading ? 'disable' : 'primary',
                  onPressed: () {
                    if (!loading) {
                      onSubmit();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showModalSelect(List<Map<String, dynamic>> item) {
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
          title: "Status Artikel",
          callback: (index, data) {
            setState(() {
              selectedItem = index;
              statusController.text = data['label'];
            });
          },
        );
      },
    );
  }
}
