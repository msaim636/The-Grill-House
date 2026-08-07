import 'package:flutter/material.dart';
import 'package:desk_flow/auth/login.dart';
import 'package:desk_flow/auth/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:desk_flow/home/home_screen.dart';
import 'package:desk_flow/seats_layout/seats_layout.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://qlsatvaimlkcterxwbcq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsc2F0dmFpbWxrY3Rlcnh3YmNxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU3MjAxNzEsImV4cCI6MjEwMTI5NjE3MX0.pSshGFG3rku9_hu4zSOHJorHVYm8qgyXiU_H7yMVDDo',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      routes: {
        '/': (context) => const Login(),
        '/splash_screen': (context) => const SplashScreen(),
        '/reg_screen': (context) => const Register(),
        '/home_screen': (context) => const HomeScreen(),
        '/seats_layout': (context) => const SeatsLayout(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    nextScreen();
  }

  final supabase = Supabase.instance.client;
  void nextScreen() async {
    await Future.delayed(Duration(milliseconds: 3));
    if (supabase.auth.currentSession == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => Login())),
        (context) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => HomeScreen())),
        (context) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
    );
  }
}
