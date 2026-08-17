import 'package:flutter/material.dart';
import 'package:lsa/services/friction_tracker.dart';
import 'package:lsa/widgets/LsaVerificationScreen.dart';
import 'api/api_client.dart';
import 'controllers/verification_controller.dart';

void main() {
  runApp(const HabotApp());
}

class HabotApp extends StatelessWidget {
  const HabotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LSA Verification',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4532B8),
        ),
      ),
      home:  VerificationHost(),
    );
  }
}

class VerificationHost extends StatelessWidget {
  VerificationHost({super.key});

  final VerificationController controller =
  VerificationController(
    scenario: MockApiScenario.success,
  );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return LsaVerificationScreen(
          controller: controller,
        );
      },
    );
  }
}