import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/main_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isLoggedIn = false;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }
  
  void setLoggedIn(bool value) {
    setState(() {
      _isLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Time Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 247, 255),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
          brightness: Brightness.dark,
          primary: const Color.fromARGB(255, 112, 112, 112),
        ),
        useMaterial3: true,
      ),
      themeMode: _themeMode,
      home: _isLoggedIn 
          ? MainScreen(onThemeChanged: toggleTheme, onLogout: () => setLoggedIn(false))
          : LoginScreen(onLogin: () => setLoggedIn(true)),
    );
  }
}