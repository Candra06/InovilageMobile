import 'package:flutter/material.dart';
import 'package:inovilage/screen/home/user/LandingUserScreen.dart';
import 'package:inovilage/static/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String role = 'user';

  loadContent() {
    switch (role) {
      case 'user':
        return const LandingUserScreen();
      default:
        return const LandingUserScreen();
    }
  }

  @override
  void initState() {
    loadContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: loadContent(),
    );
  }
}
