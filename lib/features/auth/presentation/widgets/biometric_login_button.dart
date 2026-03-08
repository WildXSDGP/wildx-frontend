// ============================================================
// Commit 1: Biometric Login Button - Base Scaffold
// Author: Savith29
// ============================================================

import 'package:flutter/material.dart';

class BiometricLoginButton extends StatefulWidget {
  const BiometricLoginButton({super.key});

  @override
  State<BiometricLoginButton> createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: const Text('Login with Biometrics'),
      ),
    );
  }
}