import 'package:flutter/material.dart';
import 'package:market/screens/login/components/login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildLogo(),
            LoginFormContainer(),
          ],
        ),
      )),
    );
  }

  Padding _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.shopping_basket_sharp,
        size: 100,
      ),
    );
  }
}
