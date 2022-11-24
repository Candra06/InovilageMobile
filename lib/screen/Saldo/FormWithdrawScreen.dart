// ignore_for_file: use_build_context_synchronously, await_only_futures

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/SaldoProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/Utils.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/SelectWidget.dart';
import 'package:provider/provider.dart';

class FromWithdrawScreen extends StatefulWidget {
  const FromWithdrawScreen({Key? key}) : super(key: key);

  @override
  State<FromWithdrawScreen> createState() => _FromWithdrawScreenState();
}

class _FromWithdrawScreenState extends State<FromWithdrawScreen> {
  TextEditingController usersController = TextEditingController(),
      saldoController = TextEditingController(),
      amountController = TextEditingController();
  bool loading = false, load = true;
  List<Map<String, dynamic>> usersList = [];
  int selectedItem = 0, saldo = 0, selectedId = 0;
  getUsers() async {
    setState(() {
      load = true;
      usersController.text = 'Loading..';
      saldoController.text = 'Loading..';
    });
    await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).listUser();
    var users = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).listUsers;
    for (var element in users) {
      usersList.add({
        "id": element.id.toString(),
        "label": element.name,
        "saldo": element.saldo,
      });
    }
    setState(() {
      usersController.text = "";
      saldoController.text = "";
      load = false;
    });
  }

  onSubmit() async {
    setState(() {
      loading = true;
    });
    if (usersController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Harap pilih users ",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (amountController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Nominal penarikan wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (int.parse(amountController.text.toString()) > saldo) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Jumlah penarikan melebihi jumlah saldo",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else {
      Map<String, dynamic> body = {
        "users_id": selectedId.toString(),
        "jumlah": amountController.text,
      };
      Provider.of<SaldoProvider>(
        context,
        listen: false,
      ).withdraw(body).then((value) {
        if (value['code'] == '00') {
          Provider.of<AuthProvider>(
            context,
            listen: false,
          ).listUser().then((data) {
            if (data['code'] == '00') {
              Navigator.pushNamed(
                context,
                Navigation.listSaldoScreen,
              );
            }
          });
        } else {
          showSnackBar(
            context,
            "Gagal",
            subtitle: value['message'],
            type: "error",
            duration: 3,
            position: 'top',
          );
        }
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getUsers();
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
              const HeaderWidget(
                title: "Penarikan Saldo",
              ),
              SizedBox(
                height: defaultMargin,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: InputWidget(
                    title: "hidden",
                    hintText: "Pilih Nama Users",
                    controller: usersController,
                    iconRight: Icons.keyboard_arrow_down_outlined,
                    readOnlyColorCustom: whiteColor,
                    readonly: true,
                    onPress: () async {
                      if (!load) {
                        _showModalSelect();
                      }
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Saldo",
                  readonly: true,
                  readOnlyColorCustom: whiteColor,
                  controller: saldoController,
                  iconLeft: Icons.money,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: defaultMargin,
                ),
                child: InputWidget(
                  title: "hidden",
                  hintText: "Jumlah Penarikan",
                  controller: amountController,
                  iconLeft: Icons.price_change,
                ),
              ),
              SizedBox(
                height: defaultMargin,
              ),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  isLoading: loading,
                  theme: loading ? 'disable' : 'primary',
                  label: "Simpan",
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
          data: usersList,
          selected: selectedItem,
          title: "Users",
          callback: (index, data) {
            setState(() {
              selectedItem = index;
              selectedId = int.parse(data['id'].toString());
              saldo = int.parse(data['saldo'].toString());
              usersController.text = data['label'];
              saldoController.text = formatrupiah(
                amount: data['saldo'].toString(),
                awalan: 'Rp. ',
              );
            });
          },
        );
      },
    );
  }
}
