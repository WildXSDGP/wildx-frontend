// ============================================================
// Commit 5: Biometric Login Button - Biometric Check
// Author: Savith29
// ============================================================

import 'package:flutter/material.dart';

class BiometricLoginButton extends StatefulWidget {
  const BiometricLoginButton({super.key});

  @override
  State<BiometricLoginButton> createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isAuthenticating = false;
  bool _biometricAvailable = true;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _checkBiometricAvailability();
  }

  // Check if biometrics available on device
  Future<void> _checkBiometricAvailability() async {
    // TODO (MAMA): Use local_auth to check
    // final LocalAuthentication auth = LocalAuthentication();
    // final bool canAuth = await auth.canCheckBiometrics;
    // setState(() => _biometricAvailable = canAuth);

    setState(() => _biometricAvailable = true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_biometricAvailable) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isAuthenticating ? _pulseAnimation.value : 1.0,
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _isAuthenticating ? null : () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF4CAF50), width: 1.8),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
              ),
              child: _isAuthenticating
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF4CAF50),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.fingerprint,
                            color: Color(0xFF4CAF50),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Login with Biometrics',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}