import 'package:flutter/material.dart';
import 'profile_screen.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatefulWidget {
  const ProfileApp({super.key});

  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  // Manage the current theme state
  ThemeMode _themeMode = ThemeMode.dark; // Changed default to Dark for the tech vibe

  // Function to toggle the theme
  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevOps Profile',
      themeMode: _themeMode,
      // --- LIGHT THEME (Crisp, Alice Blue & Violet) ---
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF4F7FC), 
      ),
      // --- DARK THEME (Midnight Blue & Neon Cyan) ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF0B0F19), 
      ),
      home: ProfileScreen(
        onThemeToggle: _toggleTheme,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }
}