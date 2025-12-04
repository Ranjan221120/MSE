import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageData {
  
  static Future<void> saveData(String key, String value) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  static Future<String?> getData(String key) async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static Future<void> clearData() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
