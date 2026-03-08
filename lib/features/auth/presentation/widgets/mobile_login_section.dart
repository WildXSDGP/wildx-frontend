// Commit 3: Mobile Login Section - Country Code Selector

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
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone_outlined, color: Colors.grey.shade400, size: 18),
                    const SizedBox(width: 6),
                    // Country Code Selector
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
            ],
          ),
        ),
      ],
    );
  }
}