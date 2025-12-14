import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _key = 'repositories';

  Future<void> saveRepositories(List<Map<String, dynamic>> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode(data));
  }

  Future<List<Map<String, dynamic>>> loadRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(json));
  }
}