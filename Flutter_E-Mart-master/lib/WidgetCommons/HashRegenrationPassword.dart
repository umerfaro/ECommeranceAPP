import 'dart:convert';
import 'package:crypto/crypto.dart';

class CredentialGenerator {
  static String generateCredential(String email) {
    // You can use any logic to generate the additional credential.
    // In this example, we'll create an MD5 hash of the user's email.
    final bytes = utf8.encode(email);
    final hash = md5.convert(bytes);
    return hash.toString();
  }
}
