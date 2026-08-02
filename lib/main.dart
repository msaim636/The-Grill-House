import 'package:flutter/material.dart';
import 'package:table_mate/auth/login.dart';
import 'package:table_mate/auth/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/reg_screen': (context) => const Register(),
      },
    );
  }
}
