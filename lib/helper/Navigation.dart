import 'package:flutter/material.dart';
import 'package:inovilage/screen/Artikel/DetailArtikelScreen.dart';
import 'package:inovilage/screen/Artikel/FormArtikelScreen.dart';
import 'package:inovilage/screen/Artikel/ListArtikelScreenMaster.dart';
import 'package:inovilage/screen/Saldo/FormWithdrawScreen.dart';
import 'package:inovilage/screen/Saldo/ListHistorySaldoScreen.dart';
import 'package:inovilage/screen/Users/FormUsersScreen.dart';
import 'package:inovilage/screen/Users/ListUsersScreen.dart';
import 'package:inovilage/screen/auth/ChangeProfileScreen.dart';
import 'package:inovilage/screen/auth/LoginScreen.dart';
import 'package:inovilage/screen/auth/RegisterScreen.dart';
import 'package:inovilage/screen/auth/SplashScreen.dart';
import 'package:inovilage/screen/delivery/AddItemScreen.dart';
import 'package:inovilage/screen/delivery/DeliveryFormScreen.dart';
import 'package:inovilage/screen/delivery/DetailPengirimanScreen.dart';
import 'package:inovilage/screen/donasi/AddItemDonasiScreen.dart';
import 'package:inovilage/screen/donasi/DetailDonasiScreen.dart';
import 'package:inovilage/screen/donasi/DonasiFormScreen.dart';
import 'package:inovilage/screen/donasi/ListDonasiScreen.dart';
import 'package:inovilage/screen/home/AccountScreen.dart';
import 'package:inovilage/screen/home/TransactionScreen.dart';
import 'package:inovilage/screen/trash/FormTrashScree.dart';
import 'package:inovilage/screen/trash/ListTrashScreen.dart';
import 'package:inovilage/widget/BottomNavigationWidget.dart';
import 'package:page_transition/page_transition.dart';

class Navigation {
  static const splashScreen = '/splashScreen';
  static const loginScreen = '/loginScreen';
  static const registerScreen = '/registerScreen';
  static const homeScreen = '/homeScreen';
  static const homeScreenAdmin = '/homeScreenAdmin';
  static const changeProfileScreen = '/changeProfileScreen';
  static const transacTionScreen = '/transacTionScreen';
  static const accountScreen = '/accountScreen';
  static const deliveryFormScreen = '/deliveryFormScreen';
  static const listSampahScreen = '/listSampahScreen';
  static const formSampahScreen = '/formSampahScreen';
  static const listUsersScreen = '/ListUsersScreen';
  static const formUsersScreen = '/FormUsersScreen';
  static const formArtikelScreen = '/FormArtikelScreen';
  static const listArtikelScreen = '/ListArtikelScreen';
  static const listDonasiScreen = '/ListDonasiScreen';
  static const formDonasiScreen = '/formDonasiScreen';
  static const detailArtikelScreen = '/detailArtikelScreen';
  static const detailPengirimanScreen = '/detailPengirimanScreen';
  static const addItemPengirimanScreen = '/addItemPengirimanScreen';
  static const detailDonaiScreen = '/detailDonaiScreen';
  static const addItemDonaiScreen = '/addItemDonaiScreen';
  static const listSaldoScreen = '/listSaldoScreen';
  static const formWtihdrawScreen = '/formWtihdrawScreen';

  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case splashScreen:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case loginScreen:
        return PageTransition(
          child: const LoginScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case registerScreen:
        return PageTransition(
          child: const RegisterScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case changeProfileScreen:
        return PageTransition(
          child: const ChangeProfileScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case homeScreen:
        return PageTransition(
          child: BottomNavigationWidget(
            selectedIndex: int.tryParse(settings.arguments.toString()) ?? 0,
          ),
          type: PageTransitionType.rightToLeft,
        );
      case homeScreenAdmin:
        return PageTransition(
          child: BottomNavigationAdminWidget(
            selectedIndex: int.tryParse(settings.arguments.toString()) ?? 0,
          ),
          type: PageTransitionType.rightToLeft,
        );
      case transacTionScreen:
        return PageTransition(
          child: const TransactionScreen(
            type: 'pengiriman',
          ),
          type: PageTransitionType.rightToLeft,
        );
      case accountScreen:
        return PageTransition(
          child: const AccountScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case deliveryFormScreen:
        return PageTransition(
          child: const DeliveryFormScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case listSampahScreen:
        return PageTransition(
          child: const ListTrashScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case formSampahScreen:
        return PageTransition(
          child: const FormTrashScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case listDonasiScreen:
        return PageTransition(
          child: const ListDonasiScreen(),
          type: PageTransitionType.rightToLeft,
        );
      case formDonasiScreen:
        return PageTransition(
          child: const DonasiFormScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case listUsersScreen:
        return PageTransition(
          child: const ListUsersScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case formUsersScreen:
        return PageTransition(
          child: const FormUsersScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case formArtikelScreen:
        return PageTransition(
          child: const FormArtikelScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case listArtikelScreen:
        return PageTransition(
          child: const ListArtikelScreenMaster(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case detailArtikelScreen:
        return PageTransition(
          child: DetailArtikelScreen(
            id: settings.arguments as String,
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case detailPengirimanScreen:
        return PageTransition(
          child: DetailPengirimanScreen(
            id: settings.arguments as String,
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case addItemPengirimanScreen:
        return PageTransition(
          child: AddItemScreen(
            id: settings.arguments as String,
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case detailDonaiScreen:
        return PageTransition(
          child: DetailDonasiScreen(
            id: settings.arguments as String,
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case addItemDonaiScreen:
        return PageTransition(
          child: AddItemDonasiScreen(
            id: settings.arguments as String,
          ),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case listSaldoScreen:
        return PageTransition(
          child: const ListHistorySaldoScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case formWtihdrawScreen:
        return PageTransition(
          child: const FromWithdrawScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SimplePage(
            title: "404 Not Found",
          ),
        );
    }
  }
}

class SimplePage extends StatelessWidget {
  const SimplePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
};
