import 'package:flutter/material.dart';

Widget buildFooter() {
  return
    Container(
    margin: const EdgeInsets.only(top: 80),
    // decoration: BoxDecoration(
    //   gradient: LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: [
    //       Colors.transparent,
    //       const Color(0xFF1e002a).withOpacity(0.3),
    //     ],
    //   ),
    //   border: Border(
    //     top: BorderSide(
    //       color: const Color(0xFF8b5cf6).withOpacity(0.3),
    //       width: 1.5,
    //     ),
    //   ),
    //),
    child: Column(
      children: [
        Container(
          width: 200,
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                const Color(0xFF8b5cf6).withOpacity(0.5),
                Colors.transparent,
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF8b5cf6).withOpacity(0.3),
                        const Color(0xFF8b5cf6).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.copyright_rounded,
                    color: Color(0xFF8b5cf6),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '2025 Syed Faireena Zaidi',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Crafted with',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFf43f5e),
                      Color(0xFFfb7185),
                    ],
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.favorite,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'using',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                const FlutterLogo(
                  textColor: Colors.white70,
                  size: 50,
                  style: FlutterLogoStyle.horizontal,
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 40),
      ],
    ),
  );
}

