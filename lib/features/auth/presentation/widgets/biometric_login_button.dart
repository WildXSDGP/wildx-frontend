// ============================================================
// Commit 8: Biometric Login Button - Error Handling
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
  bool _isSuccess = false;
  String? _errorMessage;

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

  Future<void> _checkBiometricAvailability() async {
    setState(() => _biometricAvailable = true);
  }

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() => _isSuccess = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Biometric Authentication Successful!'),
            backgroundColor: Color(0xFF4CAF50),
          ),
        );
      }
    } catch (e) {
      // Error handling
      if (mounted) {
        setState(() => _errorMessage = 'Authentication failed. Try again.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ $_errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isAuthenticating = false);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_biometricAvailable) return const SizedBox.shrink();

    return Column(
      children: [
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _isAuthenticating ? _pulseAnimation.value : 1.0,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _isAuthenticating ? null : _authenticate,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: _errorMessage != null
                          ? Colors.red
                          : _isSuccess
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFF4CAF50),
                      width: 1.8,
                    ),
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
                              child: Icon(
                                _isSuccess ? Icons.check_circle : Icons.fingerprint,
                                color: const Color(0xFF4CAF50),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _isSuccess ? 'Authenticated!' : 'Login with Biometrics',
                              style: const TextStyle(
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
        ),
        // Error message
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }
}