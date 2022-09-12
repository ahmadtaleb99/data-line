import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // Future.delayed(Duration(milliseconds: 500),() =>Navigator.pushReplacementNamed(context, Routes.loginRoute));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.flexLogo),
      ),
    );
  }
}
