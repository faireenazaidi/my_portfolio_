import 'package:flutter/material.dart';
import 'Portfolio/my_portfolio.dart';

void main() {
  runApp(PortfolioApp());
}
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  _PortfolioAppState createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Developer Portfolio',
      theme: isDarkMode ? darkTheme : lightTheme,
      home: PortfolioHome(
        isDarkMode: isDarkMode,
        onThemeToggle: () => setState(() => isDarkMode = !isDarkMode),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF1abc9c),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF0a0a0a),
    primaryColor: Color(0xFF1abc9c),
  );
}