import 'package:flutter/material.dart';
import 'theme/theme_notifier.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FaireenPortfolioApp());
}

class FaireenPortfolioApp extends StatefulWidget {
  const FaireenPortfolioApp({super.key});

  @override
  State<FaireenPortfolioApp> createState() => _FaireenPortfolioAppState();
}

class _FaireenPortfolioAppState extends State<FaireenPortfolioApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeNotifier,
      builder: (_, __) => MaterialApp(
        title: 'Faireena Zaidi — Flutter Developer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF5F2EC),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFE8470A),
          ),
          pageTransitionsTheme:  PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF141210),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFFF5A1A),
          ),
        ),
        themeMode: _themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
        home: HomeScreen(themeNotifier: _themeNotifier),
      ),
    );
  }
}
