import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inovilage/screen/home/AccountScreen.dart';
import 'package:inovilage/screen/home/HomeScreen.dart';
import 'package:inovilage/screen/home/TransactionScreen.dart';
import 'package:inovilage/static/themes.dart';
import 'package:inovilage/widget/ModalOptionWidget.dart';

class BottomNavigationWidget extends StatefulWidget {
  int selectedIndex = 0;

  BottomNavigationWidget({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const TransactionScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
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
              title: "confirmTitle",
              subtitle: "confirmClose",
              titleButtonTop: 'confirm.yes',
              titleButtonBottom: 'confirm.no',
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: _pages.elementAt(widget.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          selectedFontSize: 12,
          selectedItemColor: fontPrimaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          currentIndex: widget.selectedIndex, //New
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: fontPrimaryColor,
              ),
              activeIcon: Icon(
                Icons.home,
                color: primaryColor,
              ),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
                color: fontPrimaryColor,
              ),
              activeIcon: Icon(
                Icons.list_alt,
                color: primaryColor,
              ),
              label: "Traksaksi",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                color: fontPrimaryColor,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                color: primaryColor,
              ),
              label: "Akun",
            ),
          ],
        ),
      ),
    );
  }
}
