import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}