import 'package:flutter/material.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/screen/home/user/LandingUserScreen.dart';
import 'package:inovilage/static/themes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String role = 'Pengguna';
  getRole() async {
    var data = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).authData;
    setState(() {
      role = data.role.toString();
      loadContent();
    });
  }

  loadContent() {
    switch (role) {
      case 'Pengguna':
        return const LandingUserScreen();
      case 'Kurir':
        return const LandingUserScreen();
      default:
        return const LandingUserScreen();
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getRole();
    });
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
