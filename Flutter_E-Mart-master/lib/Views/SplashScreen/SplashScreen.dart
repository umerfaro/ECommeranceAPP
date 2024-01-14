import 'package:flutter/material.dart';
import 'package:emart_app/WidgetCommons/appLogo_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../authScreen/Login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ChangeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //using get package
      Get.off(() => const LoginScreen());
    });
  }

  @override
  void initState() {
    ChangeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Hero(
                tag: 'splash_image', // Unique tag for the image
                child: Image.asset(icSplashBg, width: 300),
              ),
            ),
            20.heightBox,
            Hero(
              tag: 'app_logo', // Unique tag for the app logo
              child: appLogoWidget(),
            ),
            10.heightBox,
            const Text(
              appname,
              style: TextStyle(
                color: whiteColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.make(),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
