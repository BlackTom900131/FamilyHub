import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;

  Future<String?> _getServer() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('server_address');
  }

  Future<bool> _loginImmich(String server, String email, String password) async {
    final url = Uri.parse('http://$server/api/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save JWT, roles, etc.
      return true;
    }
    return false;
  }

  Future<bool> _loginNextcloud(String server, String email, String password) async {
  final url = Uri.parse('http://$server/remote.php/webdav/');
  final client = http.Client();

  final request = http.Request('PROPFIND', url);
  request.headers.addAll({
    'Authorization': 'Basic ${base64Encode(utf8.encode('$email:$password'))}',
    'Depth': '0', // Or '1' if you want to list contents
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

    return response.statusCode == 207; // Multi-Status = Success for PROPFIND
  } catch (e) {
    print('Error during Nextcloud login: $e');
    return false;
  } finally {
    client.close();
  }
}

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final server = await _getServer();
    if (server == null) return;

    final immichOk = await _loginImmich(server, email, password);
    final nextcloudOk = await _loginNextcloud(server, email, password);

    if (immichOk && nextcloudOk) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      setState(() {
        _error = 'Login failed for one or both services';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unified Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}