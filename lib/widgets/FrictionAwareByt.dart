import 'package:flutter/material.dart';

import '../controllers/verification_controller.dart';
import '../services/friction_tracker.dart';
class FrictionAwareConsentField extends StatefulWidget {
  final VerificationController controller;

  const FrictionAwareConsentField({
    required this.controller,
  });

  @override
  State<FrictionAwareConsentField> createState() =>
      FrictionAwareConsentFieldState();
}
class FrictionAwareConsentFieldState
    extends State<FrictionAwareConsentField> {
  late final FrictionTracker _frictionTracker;

  @override
  void initState() {
    super.initState();

    _frictionTracker = FrictionTracker();
  }

  @override
  void dispose() {
    _frictionTracker.dispose();

    super.dispose();
  }

  void _handleFocus(bool hasFocus) {
    if (hasFocus) {
      _frictionTracker.start(
        fieldName: 'parent_consent_code',
      );
    } else {
      _frictionTracker.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: _handleFocus,
      child: TextField(
        onChanged: (value) {
          // User interacted with the field.
          _frictionTracker.stop();

          widget.controller.updateConsentCode(value);
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

