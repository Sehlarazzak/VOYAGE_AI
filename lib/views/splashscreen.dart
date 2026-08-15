import 'dart:async';
import 'package:flutter/material.dart';
import 'package:first_project/views/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3), 
      () {
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginScreen(),
        ),
        );
      }
      );
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Color(0xFFF4F7FF),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),

            const SizedBox(width: 20),

            Text(
              'VoyageAI',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF1E6AE1),
                fontWeight: FontWeight.bold,
                )
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text('Your Personal AI Travel Companion',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF6B7280),
          ),
          ),

          const SizedBox(height: 80),

          SizedBox(
            width: 250,
            child: LinearProgressIndicator(),
          )



        ],
        )
        ), );
      }
  }