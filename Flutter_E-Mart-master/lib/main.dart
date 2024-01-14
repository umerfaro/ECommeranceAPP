import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Views/SplashScreen/SplashScreen.dart';
import 'consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
      ),
        fontFamily: regular
      ),
      home: const SplashScreen(),
    );
  }
}
