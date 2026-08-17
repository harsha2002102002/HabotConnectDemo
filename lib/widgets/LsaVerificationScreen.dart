import 'package:flutter/material.dart';
import 'package:lsa/widgets/StatusBanner.dart';

import '../controllers/verification_controller.dart';
import 'Header.dart';
import 'VerificationFormCard.dart';
class LsaVerificationScreen extends StatelessWidget {
  final VerificationController controller;
  const LsaVerificationScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FC),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    VerificationFormCard(
                      controller: controller,
                    ),
                    const SizedBox(height: 20),
                    StatusBanner(
                      controller: controller,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'HabotConnect  |  Data Integrity • Security • Compliance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}