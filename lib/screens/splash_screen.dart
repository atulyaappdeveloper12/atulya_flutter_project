import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_cash/screens/currency_requirement_screen.dart';
import 'package:ui_cash/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(parent: _controller,
      curve: Curves.bounceIn);

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      navigateUser();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffe5e5e5),
        child: RotationTransition(
          turns: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset('images/uicash_logo.png'))
            ],
          ),
        ),
      ),
    );
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email= prefs.getString('email');
    print("Email: "+ email.toString());

    if (email != null) {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CurrencyRequirementScreen()));
    } else {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
