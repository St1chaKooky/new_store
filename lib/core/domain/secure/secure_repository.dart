
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureRepo {
 FlutterSecureStorage storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true,));

 Future<void> addValue(String key, String value) async {
  await storage.write(key: key, value: value);
 }
 Future<String?> readValue(String key) async{
  String? value = await storage.read(key: key);
  return value!;
 }
}