import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashscreen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text(
            'Welcome to',
            style: TextStyle(
          fontSize: 42,
          color: Colors.white,
          fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'FamilyHub',
            style: TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.bold,
            ),
          ),
        ],
          ),
        ),
      ),
    );
  }
}