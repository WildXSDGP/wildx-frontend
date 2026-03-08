// ============================================================
// Commit 6: Email Login Section - Validation Logic
// Author: Savith29
// ============================================================

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

  // Email + Password validation
  void _validate() {
    final emailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim());
    final passValid = _passwordController.text.length >= 6;
    setState(() => _isValid = emailValid && passValid);
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email Field
              const Text('Email Address',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF444444)),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.email_outlined, color: Colors.grey.shade400, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration.collapsed(
                          hintText: 'you@example.com',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Password Field
              const Text('Password',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF444444)),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration.collapsed(
                          hintText: '••••••••',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                      child: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey.shade400,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 12, color: Color(0xFF4CAF50), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}