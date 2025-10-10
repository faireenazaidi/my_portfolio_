import 'package:flutter/material.dart';
import 'SFZ/Portfolio_home.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syed Faireena Zaidi - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF8b5cf6),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'monospace',
      ),
      home: const PortfolioHome(),
    );
  }
}
