import 'package:auto_route/auto_route.dart';
import 'package:chat_app/router/app_router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1100), () async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        context.router.replace(const ChatRoute());
      } else {
        context.router.replace(const LoginRoute());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "CHAT APP",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 5,
          ),
        ),
      ),
    );
  }
}
