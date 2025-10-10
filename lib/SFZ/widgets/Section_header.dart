import 'package:flutter/material.dart';


Widget buildSectionHeader(String number, String title) {
  return Row(
    children: [
      Text(
        number,
        style: const TextStyle(
          color: Color(0xFF8b5cf6),
          fontSize: 24,
        ),
      ),
      const SizedBox(width: 16),
      Text(
        title,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 24),
      Expanded(
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF8b5cf6),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
