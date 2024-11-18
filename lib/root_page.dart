import 'package:app_movies/features/auth/presentation/sign_in/login_screen.dart';
import 'package:app_movies/features/home/presentation/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Lắng nghe trạng thái xác thực
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
