import 'package:blinders/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:blinders/pages/login_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially, show login page
  bool showLoginPage = true;

  // Toggle between login and register page
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show either LoginPage or RegisterPage based on showLoginPage flag
    if (showLoginPage) {
      return LoginPage(onTap: togglePage,
      );
    }else{
      return RegisterPage(
        onTap: togglePage,
        );
    }
  }
}
