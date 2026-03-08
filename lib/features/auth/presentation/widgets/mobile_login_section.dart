import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneLoginSection extends StatefulWidget {
  const PhoneLoginSection({super.key});

  @override
  State<PhoneLoginSection> createState() => _PhoneLoginSectionState();
}

class _PhoneLoginSectionState extends State<PhoneLoginSection> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    final phone = _phoneController.text.trim();
    // Sri Lanka: 07X XXX XXXX (10 digits)
    setState(() {
      _isValid = phone.length >= 9;
    });
  }

  void _onContinue() {
    if (!_isValid) return;

  
    // Example with Firebase:
    // FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: '+94${_phoneController.text.trim()}',
    //   verificationCompleted: ...,
    //   verificationFailed: ...,
    //   codeSent: (verificationId, resendToken) {
    //     Navigator.push(context, MaterialPageRoute(
    //       builder: (_) => OtpVerifyPage(verificationId: verificationId),
    //     ));
    //   },
    //   codeAutoRetrievalTimeout: ...,
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📲 OTP Sent! (Connect backend here)'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
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
        // ── Phone Input Card ──
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
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isValid
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade200,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: Colors.grey.shade400,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    // Country code
                    Text(
                      '+94 ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Continue Button ──
        SizedBox(
          width: double.infinity,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: _isValid ? _onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isValid
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFE0E0E0),
                foregroundColor: _isValid ? Colors.white : Colors.grey,
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
        ),
      ],
    );
  }
}