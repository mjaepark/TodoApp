import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'initial screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => LoginPage(),
      //   '/registerpage': (context) => RegisterPage(),
      //   '/register2page': (context) => Register2Page()
      // },
      title: 'logindemo',
      //디스크립션 페이지로 이동
      home: LandingPage(),
    );
  }
}
