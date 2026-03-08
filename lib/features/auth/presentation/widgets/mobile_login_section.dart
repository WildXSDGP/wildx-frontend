
// Commit 9: Mobile Login Section - Loading State

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileLoginSection extends StatefulWidget {
  const MobileLoginSection({super.key});

  @override
  State<MobileLoginSection> createState() => _MobileLoginSectionState();
}

class _MobileLoginSectionState extends State<MobileLoginSection> {
  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+94';
  bool _isValid = false;
  String? _phoneError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validate);
  }

  void _validate() {
    final phone = _phoneController.text.trim();
    setState(() {
      _isValid = phone.length >= 9;
      _phoneError = phone.isNotEmpty && !_isValid
          ? 'Please enter a valid phone number'
          : null;
    });
  }

  Future<void> _sendOTP() async {
    if (!_isValid) return;
    setState(() => _isLoading = true);

    try {
      final fullNumber = '$_countryCode${_phoneController.text.trim()}';
      // Simulating API call
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('📲 OTP sent to $fullNumber'),
            backgroundColor: const Color(0xFF4CAF50),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF444444),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _phoneError != null
                        ? Colors.red.shade300
                        : _isValid
                            ? const Color(0xFF4CAF50)
                            : Colors.grey.shade200,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone_outlined, color: Colors.grey.shade400, size: 18),
                    const SizedBox(width: 6),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _countryCode,
                        items: ['+94', '+1', '+44', '+91'].map((code) {
                          return DropdownMenuItem(value: code, child: Text(code));
                        }).toList(),
                        onChanged: (val) => setState(() => _countryCode = val!),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF222222),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration.collapsed(
                          hintText: '77 123 4567',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_phoneError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: Text(
                    _phoneError!,
                    style: const TextStyle(fontSize: 11, color: Colors.red),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isValid && !_isLoading ? _sendOTP : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isValid ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: _isValid ? 4 : 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
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
                      Icon(Icons.arrow_forward, size: 18,
                          color: _isValid ? Colors.white : Colors.grey.shade500),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}