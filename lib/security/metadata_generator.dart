import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

class MetadataGenerator {
  static const Uuid _uuid = Uuid();

  /// Generates a unique ID for every submission request.
  static String generateTraceId() {
    return _uuid.v4();
  }

  /// Generates a SHA-256 fingerprint of the verification logic version.
  static String generateLogicHash() {
    const logicVersion = 'lsa_verification_v1';

    final bytes = utf8.encode(logicVersion);

    final digest = sha256.convert(bytes);

    return digest.toString();
  }
}