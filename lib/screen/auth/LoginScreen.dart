// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/helper/PushNotificationService.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/static/SnackBar.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ButtonWidget.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:inovilage/widget/InputWidget.dart';
import 'package:inovilage/widget/ModalOptionWidget.dart';
import 'package:inovilage/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  void onSubmit() {
    if (emailController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Email wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else if (passwordController.text.isEmpty) {
      showSnackBar(
        context,
        "Warning",
        subtitle: "Password wajib diisi",
        type: "warning",
        duration: 3,
        position: 'top',
      );
    } else {
      login();
    }
  }

  login() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> body = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    await Provider.of<AuthProvider>(
      context,
      listen: false,
    )
        .login(
      body: body,
    )
        .then((value) async {
      if (value['code'] == '00') {
        await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).getUserData().then((response) async {
          if (response['code'] == '00') {
            showSnackBar(
              context,
              "Success",
              subtitle: value['message'],
              type: "success",
              duration: 5,
              position: 'top',
            );
            await Provider.of<AuthProvider>(
              context,
              listen: false,
            ).dashboard().then((resp) async {
              if (resp['code'] == '00') {
                if (response['data']['role'] == 'Pengguna') {
                  Navigator.pushNamed(
                    context,
                    Navigation.homeScreen,
                  );
                } else {
                  if (response['data']['role'] == 'Kurir') {
                    await Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    ).getStatusKurir();
                  }
                  Navigator.pushNamed(
                    context,
                    Navigation.homeScreenAdmin,
                  );
                }
              }
            });
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

  onPressBottomTop() async {
    exit(0);
  }

  onPressButtonBottom() async {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ModalOptionWidget(
              title: "Konfirmasi",
              subtitle: "Apakah anda yakin ingin menutup aplikasi?",
              titleButtonTop: 'Iya',
              titleButtonBottom: 'Tidak',
              onPressButtonTop: onPressBottomTop,
              onPressButtonBottom: onPressButtonBottom,
              imageTopHeight: 125,
              textAlign: TextAlign.center,
              axisText: CrossAxisAlignment.center,
              alignmentText: Alignment.center,
            );
          },
        )) ??
        false;
  }

  final FlutterLocalNotificationsPlugin plugins =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    PushNotificationService.initialize(plugins);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .3,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(
                    defaultBorderRadius,
                  ),
                ),
              ),
              child: const SafeArea(
                child: Center(
                  child: ImageWidget(
                    image: bgAuth,
                    width: 250,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 50,
                bottom: 33,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                children: [
                  TextWidget(
                    label: "Sign In",
                    color: primaryColor,
                    weight: 'bold',
                    type: 's1',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    label: "Please login to continue using our app",
                    color: fontSecondaryColor,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 50,
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
                      hintText: "Password",
                      controller: passwordController,
                      iconLeft: Icons.lock,
                      obscure: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 30,
                    ),
                    width: double.infinity,
                    child: TextWidget(
                      label: "Forget Password?",
                      color: fontSecondaryColor,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      theme: loading ? 'disable' : 'primary',
                      isLoading: loading,
                      label: "Sign In",
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
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Navigation.registerScreen,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 33,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label: "Don't have an account? ",
                      color: fontSecondaryColor,
                      type: 'b2',
                    ),
                    TextWidget(
                      label: "Sign Up",
                      color: primaryColor,
                      weight: 'bold',
                      type: 'b2',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
