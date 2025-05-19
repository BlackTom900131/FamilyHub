import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'immuch/photo_gallery.dart';
import 'Screens/home_screen.dart';
import 'server_connection_screen.dart';
import 'login/login_screen.dart';
import 'splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Testing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // home: PhotoGallery(
      //     imageUrls: [
      //       'https://picsum.photos/id/1011/200/200',
      //       'https://picsum.photos/id/1012/200/200',
      //       'https://picsum.photos/id/1013/200/200',
      //       // Add more URLs as needed
      //     ],
      //   ),
      debugShowCheckedModeBanner: false,
      home: SplashToLogin(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/server': (context) => const ServerConnectionScreen(),
        '/login': (context) => const LoginScreen(),
        // '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
      },
    );
  }
}

class SplashToLogin extends StatefulWidget {
  const SplashToLogin({super.key});

  @override
  State<SplashToLogin> createState() => _SplashToLoginState();
}

class _SplashToLoginState extends State<SplashToLogin> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    // final hasServer = prefs.containsKey('server_address');
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
    // if (!hasServer) {
    //   Navigator.of(context).pushReplacementNamed('/server');
    // } else {
    //   Navigator.of(context).pushReplacementNamed('/login');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
