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
      home: const VerificationHost(),
    );
  }
}
class VerificationHost extends StatefulWidget {
  const VerificationHost({super.key});

  @override
  State<VerificationHost> createState() => _VerificationHostState();
}
class _VerificationHostState extends State<VerificationHost> {
  late final VerificationController controller;

  @override
  void initState() {
    super.initState();
    controller = VerificationController(
      scenario: MockApiScenario.success,
    );
    controller.
    addListener(_onControllerChanged);
  }
  void _onControllerChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LsaVerificationScreen(
      controller: controller,
    );
  }
}
