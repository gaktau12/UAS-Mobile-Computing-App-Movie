import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.movie, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('Selamat Datang di App Movie!', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginScreen())
                );
              },
              child: const Text('Mulai'),
            )
          ],
        ),
      ),
    );
  }
}