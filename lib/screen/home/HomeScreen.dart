import 'package:flutter/material.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/screen/home/user/LandingAdminScreen.dart';
import 'package:inovilage/screen/home/user/LandingKurirScreen.dart';
import 'package:inovilage/screen/home/user/LandingUserScreen.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/LoadingWidget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String role = 'Admin';
  bool load = true;
  getRole() async {
    setState(() {
      load = true;
    });
    var data = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).authData;
    await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).listUser();
    setState(() {
      role = data!.role.toString();
      load = false;
      loadContent();
    });
  }

  loadContent() {
    switch (role) {
      case 'Pengguna':
        return const LandingUserScreen();
      case 'Kurir':
        return const LandingKurirScreen();
      default:
        return const LandingAdminScreen();
    }
  }

  @override
  void initState() {
    initializeDateFormatting();
    Future.delayed(Duration.zero, () {
      getRole();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: load ? const LoadingWidget() : loadContent(),
    );
  }
}
