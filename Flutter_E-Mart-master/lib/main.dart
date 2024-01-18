import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'Views/SplashScreen/SplashScreen.dart';
import 'consts/consts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb)
  {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBnhtKILH_8AKYGDvwkmuNKmz1hlJq6kJM",
            authDomain: "metastore-41b1a.firebaseapp.com",
            projectId: "metastore-41b1a",
            storageBucket: "metastore-41b1a.appspot.com",
            messagingSenderId: "336284957113",
            appId: "1:336284957113:web:e5a06eaff9387a09b41e68",
            measurementId: "G-VE6DS97BJ5"

        ));
  }
  else{
    await Firebase.initializeApp(
    );
  }



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
        elevation: 0,
          iconTheme: IconThemeData(color: darkFontGrey),
          backgroundColor: Colors.transparent,
      ),
        fontFamily: regular
      ),
      home: const SplashScreen(),
    );
  }
}
