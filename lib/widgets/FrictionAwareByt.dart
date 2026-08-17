import 'package:flutter/material.dart';

import '../controllers/verification_controller.dart';

class FrictionAwareConsentField extends StatelessWidget {
  final VerificationController controller;

  const FrictionAwareConsentField({
    super.key,
    required this.controller,
  });

  void _handleFocus(
      bool hasFocus,
      ) {
    if (hasFocus) {
      controller.startConsentFrictionTracking();
    } else {
      controller.stopConsentFrictionTracking();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _handleFocus,
      child: TextField(
        onChanged: (value) {
          controller.stopConsentFrictionTracking();
          controller.updateConsentCode(value);
        },
        decoration: const InputDecoration(
          hintText: 'Enter parent consent code',
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF4532B8),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}