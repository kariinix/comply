import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/account_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFD1B090),
        scaffoldBackgroundColor: const Color(0xFFF3F1E2),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final userId = settings.arguments as int;
          return MaterialPageRoute(builder: (_) => HomeScreen(userId: userId));
        }
        if (settings.name == '/account') {
          final userId = settings.arguments as int;
          return MaterialPageRoute(builder: (_) => AccountScreen(userId: userId));
        }
        return null;
      },
    );
  }
}
