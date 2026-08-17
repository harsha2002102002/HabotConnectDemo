import '../api/api_client.dart';
import '../model/verification_request.dart';
import '../security/metadata_generator.dart';

class LineageException implements Exception {
  final String message;

  const LineageException(this.message);

  @override
  String toString() {
    return 'LineageException: $message';
  }
}

class ComplianceException implements Exception {
  final String message;

  const ComplianceException(this.message);

  @override
  String toString() {
    return 'ComplianceException: $message';
  }
}

class VerificationService {
  final ApiClient apiClient;

  const VerificationService({
    required this.apiClient,
  });

  Future<void> verifyAndSubmit({
    required String lsaId,
    required String parentConsentCode,
    required String? predecessorId,
  }) async {
    // ==========================================================
    // SECURITY GATE 1
    // ==========================================================

    if (predecessorId == null ||
        predecessorId.trim().isEmpty) {
      throw const LineageException(
        'Missing predecessor_id. Data is orphaned.',
      );
    }

    // ==========================================================
    // SECURITY GATE 2
    // ==========================================================

    if (lsaId.trim().isEmpty) {
      throw const ComplianceException(
        'LSA ID is missing.',
      );
    }

    // ==========================================================
    // SECURITY GATE 3
    // ==========================================================

    if (parentConsentCode.trim().isEmpty) {
      throw const ComplianceException(
        'Parent consent code is missing.',
      );
    }

    // ==========================================================
    // Generate metadata AFTER validation passes.
    // ==========================================================

    final traceId =
    MetadataGenerator.generateTraceId();

    final logicHash =
    MetadataGenerator.generateLogicHash();

    // ==========================================================
    // Build request.
    // ==========================================================

    final request = VerificationRequest(
      predecessorId: predecessorId,
      lsaId: lsaId,
      parentConsentCode: parentConsentCode,
      timestampUtc: DateTime.now().toUtc(),
    );

    // ==========================================================
    // Send request.
    // ==========================================================

    final response =
    await apiClient.submitVerification(
      request: request,
      traceId: traceId,
      logicHash: logicHash,
    );

    // ==========================================================
    // FAIL-CLOSED RESPONSE VALIDATION
    // ==========================================================

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw const ComplianceException(
        'API returned an unsuccessful response.',
      );
    }

    if (response.data == null) {
      throw const ComplianceException(
        'API response is null.',
      );
    }

    final status = response.data!['status'];

    if (status == null) {
      throw const ComplianceException(
        'API returned null status.',
      );
    }

    if (status != 'verified') {
      throw const ComplianceException(
        'API verification failed.',
      );
    }
  }
}