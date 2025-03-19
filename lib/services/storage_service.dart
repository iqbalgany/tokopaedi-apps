import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tokenKey = "auth_token";

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Saving Token: $token");
    bool success = await prefs.setString(_tokenKey, token);
    if (success) {
      print('Token berhasil disimpan: $token');
    } else {
      print('Gagal menyimpan token!');
    }
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    print("Retrieved Token: $token");
    return token;
  }

  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
