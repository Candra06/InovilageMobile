import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:inovilage/helper/Navigation.dart';
import 'package:inovilage/provider/ArtikelProvider.dart';
import 'package:inovilage/provider/AuthProvider.dart';
import 'package:inovilage/provider/DonasiProvider.dart';
import 'package:inovilage/provider/PengirimanProvider.dart';
import 'package:inovilage/provider/SaldoProvider.dart';
import 'package:inovilage/provider/SampahProvider.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
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
        ChangeNotifierProvider<DonasiProvider>(
          create: (BuildContext context) => DonasiProvider(),
        ),
        ChangeNotifierProvider<SaldoProvider>(
          create: (BuildContext context) => SaldoProvider(),
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
