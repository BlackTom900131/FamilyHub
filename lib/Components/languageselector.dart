import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  // Default is English
  String _selectedFlag = '🇺🇸';

  final Map<String, String> languageFlags = {
    'ar': '🇸🇦',
    'en': '🇺🇸',
    'fr': '🇫🇷',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:60,
      height:50,
      child: Container(
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: PopupMenuButton<String>(
          tooltip: 'Select Language',
          icon: Text(
            _selectedFlag,
            style: const TextStyle(fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          onSelected: (String value) {
            setState(() {
              _selectedFlag = languageFlags[value] ?? '🇺🇸';
            });
            // You can also call a function to change app language here
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'ar',
              child: Row(
                children: const [
                  Text('🇸🇦', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Text('Arabic', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'en',
              child: Row(
                children: const [
                  Text('🇺🇸', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Text('English', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'fr',
              child: Row(
                children: const [
                  Text('🇫🇷', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Text('French', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
