import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealth_wizard/view/widget/bottom_bar.dart';
import 'package:wealth_wizard/main.dart';
import 'package:wealth_wizard/view/intro/loginscreen.dart';

class ScreenSplash extends StatefulWidget {
  File file;
  ScreenSplash({super.key, required this.file});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/wealth wizerd logo.png',
          height: 310,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ScreenLogin()));
  }

  Future<void> checkUserLoggedIn() async {
    final sharedpref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedpref.getBool(saveKeyName);
    if (userLoggedIn == null || userLoggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => BottomBar(
            username: "", file: File('wealth_wizard/assets/Education.jpeg')),
      ));
    }
  }
}
