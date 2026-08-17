import 'package:flutter/foundation.dart';

import '../api/api_client.dart';
import '../services/friction_tracker.dart';
import '../services/verification_service.dart';

enum VerificationStatus {
  idle,
  processing,
  success,
  quarantined,
}

class VerificationController extends ChangeNotifier {
  String lsaId = 'LSA-7049';
  bool isSubmissionLocked = false;
  String parentConsentCode = '';
  final FrictionTracker frictionTracker = FrictionTracker();
  String? predecessorId = null;

  VerificationStatus status =
      VerificationStatus.idle;

  String statusMessage =
      'System is ready. Please enter the consent code and submit.';
  late VerificationService verificationService;

  VerificationController({
    MockApiScenario scenario =
        MockApiScenario.success,
  }) {
    verificationService = VerificationService(
      apiClient: ApiClient(
        scenario: scenario,
      ),
    );
  }

  // ============================================================
  // INPUT
  // ============================================================
  @override
  void dispose() {
    frictionTracker.dispose();
    super.dispose();
  }
  void updateConsentCode(String value) {
    parentConsentCode = value;
  }
  void startConsentFrictionTracking() {
    frictionTracker.start(
      fieldName: 'parent_consent_code',
    );
  }

  void stopConsentFrictionTracking() {
    frictionTracker.stop();
  }
  // ============================================================
  // SUBMIT
  // ============================================================

  Future<void> verifyAndSubmit() async {
    if (isSubmissionLocked) {
      return;
    }
    status = VerificationStatus.processing;

    statusMessage =
    'Validating compliance data...';

    notifyListeners();

    try {
      await verificationService.verifyAndSubmit(
        lsaId: lsaId,
        parentConsentCode: parentConsentCode,
        predecessorId: predecessorId,
      );

      // --------------------------------------------------------
      // SUCCESS
      // --------------------------------------------------------

      status = VerificationStatus.success;

      statusMessage =
      'Verification completed successfully.';
    } on LineageException catch (error) {
      // --------------------------------------------------------
      // MISSING LINEAGE
      // --------------------------------------------------------

      debugPrint(error.toString());

      status =
          VerificationStatus.quarantined;

      statusMessage =
      'Data Quarantined – Missing predecessor_id';
    } on ComplianceException catch (error) {
      // --------------------------------------------------------
      // COMPLIANCE FAILURE
      // --------------------------------------------------------

      debugPrint(error.toString());

      _quarantineData(
        error.message,
      );
    } catch (error) {
      // --------------------------------------------------------
      // UNKNOWN ERROR
      // --------------------------------------------------------

      debugPrint(
        'Unexpected error: $error',
      );

      _quarantineData(
        'Unexpected compliance failure.',
      );
    }

    notifyListeners();
  }

  // ============================================================
  // FAIL-CLOSED
  // ============================================================

  void _quarantineData(String reason) {
    // Purge volatile user data.
    parentConsentCode = '';

    // Remove lineage from active state.
    predecessorId = null;

    // Lock further submissions.
    isSubmissionLocked = true;

    status = VerificationStatus.quarantined;

    statusMessage =
    'Data Quarantined – Compliance Failure';
  }

  // ============================================================
  // TEST HELPERS
  // ============================================================

  void simulateMissingLineage() {
    predecessorId = null;

    status = VerificationStatus.idle;

    statusMessage =
    'System is ready. Please enter the consent code and submit.';

    notifyListeners();
  }

  void resetLineage() {
    predecessorId = 'PRED-9982-XYZ';

    status = VerificationStatus.idle;

    statusMessage =
    'System is ready. Please enter the consent code and submit.';

    notifyListeners();
  }
}