import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel {
  Future<String?> getServer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('server_address');
  }

  Future<bool> loginImmich(String server, String email, String password) async {
    final url = Uri.parse('http://$server/api/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response.statusCode == 200;
  }

  Future<bool> loginNextcloud(String server, String email, String password) async {
    final url = Uri.parse('http://$server/remote.php/webdav/');
    final client = http.Client();

    final request = http.Request('PROPFIND', url);
    request.headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$email:$password'))}',
      'Depth': '0',
      'Content-Type': 'text/xml',
    });
    request.body = '''<?xml version="1.0"?>
<propfind xmlns="DAV:">
  <prop>
    <displayname/>
  </prop></propfind>''';

    try {
      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      return response.statusCode == 207;
    } catch (_) {
      return false;
    } finally {
      client.close();
    }
  }
}