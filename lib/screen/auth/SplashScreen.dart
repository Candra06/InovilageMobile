import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/static/images.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ImageWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, Navigation.loginScreen);
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
