import 'package:flutter/material.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/provider/SampahProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
        ChangeNotifierProvider<SampahProvider>(
          create: (BuildContext context) => SampahProvider(),
        ),
        ChangeNotifierProvider<ArtikelProvider>(
          create: (BuildContext context) => ArtikelProvider(),
        ),
        ChangeNotifierProvider<PengirimanProvider>(
          create: (BuildContext context) => PengirimanProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bank Sampah',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Navigation.generateRoute,
        initialRoute: Navigation.splashScreen,
      ),
    );
  }
}
