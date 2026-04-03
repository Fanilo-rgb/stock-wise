import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EncryptionService {
  static const _storage = FlutterSecureStorage();
  static const _keyName = "hive_encryption_key";

  static Future<HiveCipher> getHiveCipher() async {
    final existingKey = await _storage.read(key: _keyName);

    if (existingKey != null) {
      final keyBytes = base64Decode(existingKey);
      return HiveAesCipher(keyBytes);
    }

    final newKey = Hive.generateSecureKey();
    await _storage.write(key: _keyName, value: base64Encode(newKey));

    debugPrint(' New encryption key generated and stored securely.');

    return HiveAesCipher(newKey);
  }
}
