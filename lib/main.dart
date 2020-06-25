import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/app_init_screen.dart';
import 'package:fooddelivery/screens/home_screen.dart';
import 'package:fooddelivery/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AppInitScreen.id: (context) => AppInitScreen(),
        HomeScreen.id: (context) => HomeScreen(),
      },
    );
  }
}
