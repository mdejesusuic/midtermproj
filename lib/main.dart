import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'dashboard_screen.dart';
import 'onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // To manage theme switching
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Project',
      theme: _isDarkMode
          ? ThemeData.dark() // Use dark theme
          : ThemeData.light(), // Use light theme
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
      // Error handling for routes
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("404")),
          body: Center(child: Text("Page not found!")),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function toggleTheme;

  MyHomePage({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => toggleTheme(),
          ),
        ],
      ),
      body: Center(child: Text("Welcome to the Home Screen!")),
    );
  }
}
