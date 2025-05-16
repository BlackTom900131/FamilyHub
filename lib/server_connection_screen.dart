import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerConnectionScreen extends StatefulWidget {
  const ServerConnectionScreen({super.key});

  @override
  State<ServerConnectionScreen> createState() => _ServerConnectionScreenState();
}

class _ServerConnectionScreenState extends State<ServerConnectionScreen> {
  final _controller = TextEditingController();
  String? _error;

  Future<void> _saveServer(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_address', value);
  }

  bool _validate(String value) {
    final ipRegex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    final domainRegex = RegExp(r'^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return ipRegex.hasMatch(value) || domainRegex.hasMatch(value);
  }

  void _submit() {
    final value = _controller.text.trim();
    if (_validate(value)) {
      _saveServer(value).then((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
    } else {
      setState(() {
        _error = 'Invalid IP or domain format';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect to Server')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Server IP or Domain',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}