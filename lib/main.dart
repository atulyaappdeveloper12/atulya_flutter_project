import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_cash/screens/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      supportedLocales: [
        Locale('en','US')
      ],
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
