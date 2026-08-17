import '../model/verification_request.dart';

enum MockApiScenario {
  success,
  serverError,
  nullResponse,
}

class ApiResponse {
  final int statusCode;
  final Map<String, dynamic>? data;

  const ApiResponse({
    required this.statusCode,
    required this.data,
  });

  bool get isSuccessful {
    return statusCode >= 200 &&
        statusCode < 300 &&
        data != null;
  }
}

class ApiClient {
  final MockApiScenario scenario;

  const ApiClient({
    this.scenario = MockApiScenario.success,
  });
  static const String endpoint =
      'https://api.habotconnect.com/v1/compliance/verify';
  Future<ApiResponse> submitVerification({
    required VerificationRequest request,
    required String traceId,
    required String logicHash,
  }) async {
    // Simulate network delay.
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // ----------------------------------------------------------
    // Print what would be sent to the real API.
    // ----------------------------------------------------------

    print('========================================');
    print('HTTP POST');
    print(endpoint);
    print('========================================');

    print('HEADERS');

    print('Content-Type: application/json');

    print('x-trace-id: $traceId');

    print('x-logic-hash: $logicHash');

    print('BODY');

    print(request.toJson());

    print('========================================');

    // ----------------------------------------------------------
    // Mock scenarios for the hiring demonstration.
    // ----------------------------------------------------------

    switch (scenario) {
      case MockApiScenario.success:
        return const ApiResponse(
          statusCode: 200,
          data: {
            'status': 'verified',
          },
        );

      case MockApiScenario.serverError:
        return const ApiResponse(
          statusCode: 500,
          data: {
            'status': 'server_error',
          },
        );

      case MockApiScenario.nullResponse:
        return const ApiResponse(
          statusCode: 200,
          data: {
            'status': null,
          },
        );
    }
  }
}