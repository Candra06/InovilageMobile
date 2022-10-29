import 'package:flutter/material.dart';
import 'package:inovilage/screen/auth/SplashScreen.dart';

class Navigation {
  static const splashScreen = '/splashScreen';

  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case splashScreen:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(
                // data: settings.arguments.toString(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => const SimplePage(
                  title: "404 Not Found",
                ));
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
