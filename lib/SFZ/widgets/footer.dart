import 'package:flutter/material.dart';

Widget buildFooter() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(
          color: const Color(0xFF8b5cf6).withOpacity(0.3),
        ),
      ),
    ),
    child: const Center(
      child: Text(
        '© 2025 Syed Faireena Zaidi | Built with Flutter',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    ),
  );
}
