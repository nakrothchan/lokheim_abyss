import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lokheim_abyss/config/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<dynamics> fetchPages() async {
    final response = await http.get(
    Uri.parse('$API_URL/api/pages'),
    headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
  static Future<dynamics> fetchPage(String id) async {
  final response = await http.get(
    Uri.parse('$API_URL/api/pages/$id'),
    headers: {'Content-Type': 'application/json'},
  );
  return jsonDecode(response.body);
}

  static fetchBanner() {}

}

class dynamics {
}



