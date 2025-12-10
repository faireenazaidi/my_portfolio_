import 'package:flutter/material.dart';

Widget buildSectionHeader(BuildContext context, String number, String title) {
  double screenWidth = MediaQuery.of(context).size.width;

  // Smaller responsive sizes
  double numberFontSize = screenWidth * 0.03;   // 3%
  double titleFontSize  = screenWidth * 0.045;  // 4.5%

  // Clamp smaller to avoid huge text
  numberFontSize = numberFontSize.clamp(14.0, 30.0);
  titleFontSize  = titleFontSize.clamp(18.0, 40.0);

  return Row(
    children: [
      Text(
        number,
        style: TextStyle(
          color: const Color(0xFF8b5cf6),
          fontSize: numberFontSize,
        ),
      ),
      const SizedBox(width: 16),
      Text(
        title,
        style: TextStyle(
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 24),
      Expanded(
        child: Container(
          height: 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8b5cf6),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
