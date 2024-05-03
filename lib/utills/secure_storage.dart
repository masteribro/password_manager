import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static Future<dynamic> fetch(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static Future save(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }
}