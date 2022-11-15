import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/helper/Pref.dart';
import 'package:inovilage/provider/AuthProvider.dart';
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
    if (token.toString().isEmpty) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, Navigation.loginScreen);
      });
    } else {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).dashboard();
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).getUserData().then((value) {
        if (value['code'] == '00') {
          Navigator.pushNamed(context, Navigation.homeScreen);
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
