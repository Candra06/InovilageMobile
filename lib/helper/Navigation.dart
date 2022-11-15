import 'package:flutter/material.dart';
import 'package:inovilage/screen/auth/LoginScreen.dart';
import 'package:inovilage/screen/auth/RegisterScreen.dart';
import 'package:inovilage/screen/auth/SplashScreen.dart';
import 'package:inovilage/screen/delivery/DeliveryFormScreen.dart';
import 'package:inovilage/screen/home/AccountScreen.dart';
import 'package:inovilage/screen/home/TransactionScreen.dart';
import 'package:inovilage/screen/trash/ListTrashScreen.dart';
import 'package:inovilage/widget/BottomNavigationWidget.dart';
import 'package:page_transition/page_transition.dart';

class Navigation {
  static const splashScreen = '/splashScreen';
  static const loginScreen = '/loginScreen';
  static const registerScreen = '/registerScreen';
  static const homeScreen = '/homeScreen';
  static const transacTionScreen = '/transacTionScreen';
  static const accountScreen = '/accountScreen';
  static const deliveryFormScreen = '/deliveryFormScreen';
  static const listSampahScreen = '/listSampahScreen';

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
      case homeScreen:
        return PageTransition(
          child: BottomNavigationWidget(
            selectedIndex: int.tryParse(settings.arguments.toString()) ?? 0,
          ),
          type: PageTransitionType.rightToLeft,
        );
      case transacTionScreen:
        return PageTransition(
          child: const TransactionScreen(),
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
