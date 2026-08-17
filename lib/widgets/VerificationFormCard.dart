import 'package:flutter/material.dart';
import '../controllers/verification_controller.dart';
import 'FrictionAwareByt.dart';
class VerificationFormCard extends StatelessWidget {
  final VerificationController controller;

  const VerificationFormCard({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LSA ID',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF171743),
            ),
          ),

          const SizedBox(height: 10),

          _ReadOnlyField(
            value: controller.lsaId,
            icon: Icons.lock_outline,
          ),

          const SizedBox(height: 8),

          const Text(
            'System generated LSA identifier',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),

          const SizedBox(height: 28),

          const Row(
            children: [
              Text(
                'Parent Consent Code',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF171743),
                ),
              ),
              SizedBox(width: 4),
              Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          FrictionAwareConsentField(
            controller: controller,
          ),

          const SizedBox(height: 8),

          const Text(
            'Enter the consent code provided by the parent',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'Predecessor ID (Read-only)',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF171743),
            ),
          ),

          const SizedBox(height: 10),

          _ReadOnlyField(
            value: controller.predecessorId ?? 'NULL',
            icon: Icons.lock_outline,
          ),

          const SizedBox(height: 8),

          const Text(
            'System lineage identifier (cannot be modified)',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: controller.isSubmissionLocked
                  ? null
                  : controller.verifyAndSubmit,
              icon: const Icon(
                Icons.verified_user_outlined,
                color: Colors.white,
              ),
              label: const Text(
                'Verify & Submit',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4532B8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ReadOnlyField extends StatelessWidget {
  final String value;
  final IconData icon;

  const _ReadOnlyField({
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFD1D5DB),
        ),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFCFCFD),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF20202A),
              ),
            ),
          ),
          Icon(
            icon,
            color: const Color(0xFF777777),
          ),
        ],
      ),
    );
  }
}