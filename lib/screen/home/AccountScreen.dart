import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:inovilage/widget/ModalOptionWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool loading = false;
  logOut() async {
    setState(() {
      loading = true;
    });
    Navigator.pushReplacementNamed(
      context,
      Navigation.loginScreen,
    );
    Provider.of<AuthProvider>(
      context,
      listen: false,
    ).logout().then((value) {
      if (mounted) {
        setState(() {
          loading = false;
        });
        if (value['code'] == '00') {
        } else {}
      }
    });
  }

  updateStatus(String status) async {
    setState(() {
      loading = true;
    });
    if (status == 'Inorder') {
      showSnackBar(
        context,
        'Gagal merubah status',
        subtitle: "Anda sedang dalam order, silahkan hubungi admin",
        type: 'error',
        duration: 5,
        position: 'Top',
      );
    } else {
      Provider.of<AuthProvider>(
        context,
        listen: false,
      ).updateStatusKurir(body: {"status": "Ready"}).then((value) {
        if (value['code'] == '00') {
          Provider.of<AuthProvider>(
            context,
            listen: false,
          ).getStatusKurir().then((response) {
            if (response['code'] == '00') {
              showSnackBar(
                context,
                '',
                subtitle: value['message'],
                type: 'success',
                duration: 5,
                position: 'Top',
              );
            }
          });
        } else {
          showSnackBar(
            context,
            '',
            subtitle: value['message'],
            type: 'error',
            duration: 5,
            position: 'Top',
          );
        }
      });
    }
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          child: Consumer<AuthProvider>(
            builder: (context, user, child) {
              return Column(
                children: [
                  const HeaderWidget(
                    title: "Profile",
                    hideBackPress: true,
                  ),
                  SizedBox(
                    height: defaultMargin * 3,
                  ),
                  const ImageWidget(
                    image: iconPengguna,
                    height: 125,
                    width: 125,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextWidget(
                    label: "${user.authData!.role}",
                    weight: 'bold',
                    color: secondaryColor,
                    type: 's1',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    label: "${user.authData!.name}",
                    weight: 'bold',
                    color: secondaryColor,
                    type: 's2',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Navigation.changeProfileScreen,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: defaultMargin,
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            label: "Edit Profil",
                            type: 'l1',
                            color: fontPrimaryColor,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: fontSecondaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Navigation.listSaldoScreen,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: defaultMargin,
                      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            label: "Riwayat Saldo",
                            type: 'l1',
                            color: fontPrimaryColor,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: fontSecondaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  user.authData!.role == 'Kurir'
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (user.statusKurir['status'] == 'Inorder') {
                                  showSnackBar(
                                    context,
                                    'Gagal merubah status',
                                    subtitle:
                                        "Anda sedang dalam order, silahkan hubungi admin",
                                    type: 'error',
                                    duration: 5,
                                    position: 'Top',
                                  );
                                } else {
                                  showConfirmDelete(
                                    user.statusKurir['status'],
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: defaultMargin,
                                ),
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      label: "Ubah Status",
                                      type: 'l1',
                                      color: fontPrimaryColor,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: fontSecondaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: defaultMargin,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: defaultMargin,
                    ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          label: "Bantuan",
                          type: 'l1',
                          color: fontPrimaryColor,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: fontSecondaryColor,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      logOut();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        vertical: defaultMargin,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            defaultBorderRadius * 2,
                          ),
                        ),
                        border: Border.all(
                          color: secondaryColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loading
                              ? const SizedBox(
                                  child: LoadingWidget(
                                    customWidth: 20,
                                    customHeight: 20,
                                  ),
                                  height: 30.0,
                                  width: 30.0,
                                )
                              : Icon(
                                  Icons.logout_outlined,
                                  color: secondaryColor,
                                ),
                          loading
                              ? const SizedBox()
                              : TextWidget(
                                  label: "Logout",
                                  type: 'b1',
                                  color: secondaryColor,
                                  weight: 'bold',
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  showConfirmDelete(String status) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ModalOptionWidget(
          contraintHeight: 225,
          title: "Konfirmasi",
          subtitle: 'Apakah anda yakin ingin mengubah status anda?',
          titleButtonTop: status == 'Ready' ? 'Close' : 'Ready',
          isLoading: loading,
          onPressButtonTop: () => updateStatus(status),
          onPressButtonBottom: () => Navigator.pop(context),
          titleButtonBottom: 'Kembali',
          textAlign: TextAlign.start,
          axisText: CrossAxisAlignment.start,
          alignmentText: Alignment.centerLeft,
        );
      },
    );
  }
}
