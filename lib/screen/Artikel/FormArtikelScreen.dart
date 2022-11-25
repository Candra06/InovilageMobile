import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/CardArtikelWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
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
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          child: Column(
            children: <Widget>[
              const HeaderWidget(
                title: "Tambah Artikel",
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
                      hintText: "Nama Lengkap",
                      controller: titleController,
                      iconLeft: Icons.account_circle_outlined,
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
                      controller: titleController,
                      iconLeft: Icons.account_circle_outlined,
                    ),
                  ),
                  HtmlEditor(
                    controller: controller,
                    htmlEditorOptions: const HtmlEditorOptions(
                      hint: 'Your text here...',
                      shouldEnsureVisible: false,
                    ),
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.aboveEditor, //by default
                      toolbarType: ToolbarType.nativeGrid, //by default
                    ),
                    otherOptions: OtherOptions(height: 550),
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
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
