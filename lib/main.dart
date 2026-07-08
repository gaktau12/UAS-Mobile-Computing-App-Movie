import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS Movie App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}