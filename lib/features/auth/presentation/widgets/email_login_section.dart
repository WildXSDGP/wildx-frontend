
// EmailLoginSection — Email & Biometric Authentication
// Author: Savith29
// Feature: WildX Login Page
import 'package:flutter/material.dart';

class EmailLoginSection extends StatefulWidget {
  const EmailLoginSection({super.key});

  @override
  State<EmailLoginSection> createState() => _EmailLoginSectionState();
}

class _EmailLoginSectionState extends State<EmailLoginSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validate);
    _passwordController.addListener(_validate);
  }

  void _validate() {
    final emailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim());
    final passValid = _passwordController.text.length >= 6;
    setState(() => _isValid = emailValid && passValid);
  }

  void _onContinue() {
    if (!_isValid) return;

    
    // Example Firebase:
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: _emailController.text.trim(),
    //   password: _passwordController.text,
    // );
    // Navigator.pushReplacementNamed(context, '/home');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Email login — Connect backend here!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Email + Password Card ──
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email field
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                ),
              ),
              const SizedBox(height: 10),
              _inputField(
                controller: _emailController,
                hint: 'you@example.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Password field
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                ),
              ),
              const SizedBox(height: 10),
              _inputField(
                controller: _passwordController,
                hint: '••••••••',
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey.shade400,
                    size: 18,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to forgot password screen
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Continue Button ──
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isValid ? _onContinue : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isValid
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFE0E0E0),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: _isValid ? 4 : 0,
              shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _isValid ? Colors.white : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  size: 18,
                  color: _isValid ? Colors.white : Colors.grey.shade500,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade400, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF222222),
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }
}