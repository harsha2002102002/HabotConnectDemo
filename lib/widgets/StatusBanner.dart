import 'package:flutter/material.dart';

import '../controllers/verification_controller.dart';
class StatusBanner extends StatelessWidget {
  final VerificationController controller;

  const StatusBanner({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    String statusText;

    switch (controller.status) {
      case VerificationStatus.idle:
        statusText = 'Idle';
        break;

      case VerificationStatus.processing:
        statusText = 'Processing';
        break;

      case VerificationStatus.success:
        statusText = 'Success';
        break;

        case VerificationStatus.quarantined:
        statusText = 'Quarantined (Fail-Closed)';
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDAD4FF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE6E1FF),
            ),
            child: const Icon(
              Icons.info_outline,
              color: Color(0xFF4532B8),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4532B8),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  statusText,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF29206F),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  controller.statusMessage,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Color(0xFF5E6272),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}