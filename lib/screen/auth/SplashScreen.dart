// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/helper/Pref.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/SampahProvider.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ImageWidget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getToken() async {
    var token = await Pref.getToken();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(
        context,
        Navigation.loginScreen,
      );
    });
    if (token.toString().isEmpty || token == null) {
    } else {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).getUserData().then((value) async {
        if (value['code'] == '00') {
          await Provider.of<AuthProvider>(
            context,
            listen: false,
          ).dashboard().then((req) async {
            if (req['code'] == '00') {
              if (value['data']['role'] == 'Pengguna') {
                Navigator.pushNamed(context, Navigation.homeScreen);
              } else {
                if (value['data']['role'] == 'Kurir') {
                  await Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).getStatusKurir();
                }
                Navigator.pushNamed(context, Navigation.homeScreenAdmin);
              }
            }
          });
          // }
        }
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getToken();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: const Center(
        child: ImageWidget(
          image: logo,
          width: 250,
        ),
      ),
    );
  }
}
