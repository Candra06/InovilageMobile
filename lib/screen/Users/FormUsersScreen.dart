// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:provider/provider.dart';

class FormUsersScreen extends StatefulWidget {
  const FormUsersScreen({Key? key}) : super(key: key);

  @override
  State<FormUsersScreen> createState() => _FormUsersScreenState();
}

class _FormUsersScreenState extends State<FormUsersScreen> {
  String typePage = "Pengguna",
      method = "add",
      id = "",
      latitude = "",
      longitude = "";
  bool loading = false;
  TextEditingController nameController = TextEditingController(),
      hpController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      addressController = TextEditingController();

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
    } else if (hpController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Nomor telepon wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (emailController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Email wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (passwordController.text.isEmpty && method == 'add') {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Password wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (addressController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Alamat wajib diisi",
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
    List<Location> locations =
        await locationFromAddress(addressController.text);
    Map<String, dynamic> body = {
      "name": nameController.text,
      "email": emailController.text,
      "phone": hpController.text,
      "password": passwordController.text,
      "role": typePage,
      "status": "Aktif",
      "latitude": locations[0].latitude.toString(),
      "longitude": locations[0].longitude.toString(),
      "alamat": addressController.text
    };

    await Provider.of<AuthProvider>(
      context,
      listen: false,
    )
        .register(
      body: body,
    )
        .then((value) async {
      if (value['code'] == '00') {
        successRequest();
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
    List<Location> locations =
        await locationFromAddress(addressController.text);
    Map<String, dynamic> body = {
      "id": id,
      "name": nameController.text,
      "email": emailController.text,
      "phone": hpController.text,
      "role": typePage,
      "status": "Aktif",
      "latitude": locations[0].latitude.toString(),
      "longitude": locations[0].longitude.toString(),
      "alamat": addressController.text
    };
    if (passwordController.text.isNotEmpty) {
      body["password"] = passwordController.text;
    }

    await Provider.of<AuthProvider>(
      context,
      listen: false,
    )
        .updateProfil(
      body: body,
    )
        .then((value) async {
      if (value['code'] == '00') {
        showSnackBar(
          context,
          "Success",
          subtitle: value['message'],
          type: "success",
          duration: 5,
          position: 'top',
        );
        successRequest();
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

  successRequest() async {
    await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).listUser().then((respon) {
      if (respon['code'] == '00') {
        Navigator.pop(context);
      }
    });
  }

  getPage() {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args.isNotEmpty) {
      typePage = args['typepage'];

      if (args['data'] != null) {
        Map data = args['data'];

        nameController.text = data['name'];
        emailController.text = data['email'];
        hpController.text = data['phone'];
        addressController.text = data['alamat'];
        id = data['id'].toString();
        latitude = data['lat_address'].toString();
        longitude = data['long_address'].toString();
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
                title: typePage == "Pengguna" && method == 'add'
                    ? "Tambah Data Pengguna"
                    : typePage == "Pengguna" && method == 'edit'
                        ? "Edit Data Pengguna"
                        : typePage == "Kurir" && method == 'add'
                            ? "Tambah Data Kurir"
                            : "Edit Data Kurir",
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
                  hintText: "Name",
                  controller: nameController,
                  iconLeft: Icons.account_circle_outlined,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "No Hp",
                  controller: hpController,
                  iconLeft: Icons.phone_android_rounded,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "E-mail",
                  controller: emailController,
                  iconLeft: Icons.mail,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Alamat",
                  
                  maxChar: 255,
                  controller: addressController,
                  iconLeft: Icons.location_on_outlined,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                  bottom: 20,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Password",
                  controller: passwordController,
                  obscure: true,
                  iconLeft: Icons.lock,
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
}
