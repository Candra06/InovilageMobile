import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/HeaderWidger.dart';
import 'package:inovilage/widget/ImageWidget.dart';
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
    Provider.of<AuthProvider>(
      context,
      listen: false,
    ).logout().then((value) {
      setState(() {
        loading = false;
      });
      if (value['code'] == '00') {
        Navigator.pushReplacementNamed(
          context,
          Navigation.loginScreen,
        );
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    label: "Username",
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultMargin,
                      horizontal: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultMargin,
                      horizontal: 20,
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
                              ? SizedBox(
                                  child: CircularProgressIndicator(
                                    color: secondaryColor,
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
          )),
    ));
  }
}
